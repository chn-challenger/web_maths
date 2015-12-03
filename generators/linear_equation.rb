require './generators/evaluate'
require './generators/equation'

include Evaluate

class LinearEquation < Equation

  DEFAULT_RANGE = {add:50,subtract:50,multiply:9,divide:9}
  MULTIPLY_DIVIDE = [:multiply,:divide]
  ADD_SUBTRACT = [:add,:subtract]
  ORIENTATIONS = [:left,:right]



  def self.generate(options={steps:1,solution_range:10,variable:'x'})
    solution = rand(2..options[:solution_range])
    left_side = []
    current_value = solution
    options[:steps].times do
        next_step = self._next_step(left_side,current_value,options)
        current_value = evaluate(current_value,[next_step])
        left_side << next_step
    end
    left_expression = Expression.new(options[:variable],left_side)
    right_expression = Expression.new(current_value)
    equation_solution = {options[:variable] => solution}
    LinearEquation.new(left_expression,right_expression,equation_solution)
  end

  def generate_solution
    solution_equations = []
    equation = self.copy
    solution_equations << equation
    while true
      equation = equation._solution_next_step
      solution_equations << equation
      break if equation.left_side.steps.count == 0 && equation.right_side.steps.count == 0
    end
    solution_equations
  end

  def generate_latex(with_align=false)
    if with_align
      _single_expression(left_side) + '&=' + _single_expression(right_side)
    else
      _single_expression(left_side) + '=' + _single_expression(right_side)
    end
  end

  def generate_solution_latex
    solutions = generate_solution
    result = ''
    solutions.each do |solution_equation|
      result += solution_equation.generate_latex(true) + '\\\\' + "\n"
    end
    result.slice!(-3..-1)
    result
  end

  def _single_expression(expression)
    step_number = 1
    expression.steps.inject(expression.initial_value.to_s) do |result, step|
      result = _equation_next_step(result,step,step_number)
      step_number += 1
      result
    end
  end

  def _equation_next_step(current_latex,step,step_number)
    modified_latex = current_latex

    if step.operation == :add && step.orientation == :left
        modified_latex = step.value.to_s + '+' + modified_latex
    end

    if step.operation == :add && step.orientation == :right
      modified_latex = modified_latex +  '+' + step.value.to_s
    end

    if step.operation == :subtract && step.orientation == :left
        modified_latex = step.value.to_s + '-' + modified_latex
    end

    if step.operation == :subtract && step.orientation == :right
      modified_latex = modified_latex +  '-' + step.value.to_s
    end

    if step.operation == :multiply
      if step_number == 1
        modified_latex = step.value.to_s + modified_latex
      else
        modified_latex = step.value.to_s + '\left(' + modified_latex + '\right)'
      end
    end

    if step.operation == :divide && step.orientation == :left
      modified_latex = '\frac{' + step.value.to_s + '}{' + modified_latex +  '}'
    end

    if step.operation == :divide && step.orientation == :right
      modified_latex = '\frac{' + modified_latex + '}{' + step.value.to_s +  '}'
    end

    modified_latex
  end


  def _solution_next_step
    self_copy = self.copy
    if (left_side.initial_value.is_a?(Integer) && left_side.steps.count > 0) || (right_side.initial_value.is_a?(Integer) && right_side.steps.count > 0)
      return self_copy._valuation_next_step
    end
    if (left_side.initial_value.is_a?(String) && left_side.steps.count > 0) || (right_side.initial_value.is_a?(String) && right_side.steps.count > 0)
      return self_copy._reverse_last_step
    end
    return self_copy
  end

  def _reverse_last_step
    if (left_side.initial_value.is_a?(String) && left_side.steps.count > 0)
      last_step = left_side.steps.pop
      side_swap = true if last_step.orientation == :left && (last_step.operation == :divide || last_step.operation == :subtract)
      reverse_of_last_step = last_step.reverse
      right_side.steps << reverse_of_last_step
    end
    if (right_side.initial_value.is_a?(String) && right_side.steps.count > 0)
      last_step = right_side.steps.pop
      side_swap = true if last_step.orientation == :left && (last_step.operation == :divide || last_step.operation == :subtract)
      reverse_of_last_step = last_step.reverse
      left_side.steps << reverse_of_last_step
    end
    @left_side, @right_side = right_side, left_side if side_swap
    return self
  end

  def _valuation_next_step
    if (left_side.initial_value.is_a?(Integer) && left_side.steps.count > 0)
      @left_side = left_side.evaluate_next_step
    end
    if (right_side.initial_value.is_a?(Integer) && right_side.steps.count > 0)
      @right_side = right_side.evaluate_next_step
    end
    return self
  end

  private

  def self._next_step(left_side,current_value,options)
    next_step = EquationStep.new()
    next_step.operation = self._current_step_operation(left_side,options)
    next_step.orientation = self._current_step_orientation
    self._set_next_step_value(current_value,next_step,options)
    next_step.normalize
  end

  def self._current_step_operation(left_side,options)
    multiply_divide = MULTIPLY_DIVIDE.dup
    unless !!options[:more_than_one_division]
      left_side.each do |step|
        multiply_divide = [:multiply] if step.operation == :divide
      end
    end
    return [multiply_divide,ADD_SUBTRACT].sample.sample if left_side.count == 0
    ADD_SUBTRACT.include?(left_side.last.operation) ? multiply_divide.sample : ADD_SUBTRACT.sample
  end

  def self._current_step_orientation
    ORIENTATIONS.sample
  end

  def self._set_next_step_value(current_value,next_step,options)
    current_step_range = options[next_step.operation] ?
      options[next_step.operation] : DEFAULT_RANGE[next_step.operation]
    if next_step.operation == :subtract && next_step.orientation == :left
      next_step.value = current_value + rand(2..current_step_range)
    end
    if next_step.operation == :subtract && next_step.orientation == :right
      current_step_range = [current_value,current_step_range].min - 1
      if current_step_range < 2
        next_step.operation = :add
        current_step_range = options[next_step.operation] ?
          options[next_step.operation] : DEFAULT_RANGE[next_step.operation]
      end
    end
    if next_step.operation == :divide && next_step.orientation == :left
      next_step.value = current_value * rand(2..current_step_range)
    end
    if next_step.operation == :divide && next_step.orientation == :right
      choices = self._divisors_of(current_value, current_step_range)
      if choices.count == 0
        next_step.orientation = :left
        next_step.value = current_value * rand(2..current_step_range)
      else
        next_step.value = choices.sample
      end
    end
    next_step.value ||= rand(2..current_step_range)
  end

  def self._divisors_of(number,max)
    range = number < 0 ? number * -1 : number
    (1..range).select { |n| range % n == 0 && n != 1 && n <= max}
  end

end
