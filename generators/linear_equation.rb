# require './generators/equation_step'
require './generators/evaluate'
require './generators/equation'

include Evaluate

class LinearEquation < Equation

  DEFAULT_RANGE = {add:50,subtract:50,multiply:9,divide:9}
  MULTIPLY_DIVIDE = [:multiply,:divide]
  ADD_SUBTRACT = [:add,:subtract]
  ORIENTATIONS = [:left,:right]

  # attr_reader :left_side, :right_side, :solution
  #
  # def initialize(left_side,right_side,solution)
  #   @left_side = left_side
  #   @right_side = right_side
  #   @solution = solution
  # end
  def self.generate(number_of_questions=1,options={steps:1,solution_range:10,variable:'x'})
    questions = []
    number_of_questions.times do
      questions << self._generate_one(options)
    end
    questions
  end

  def self._generate_one(options={steps:1,solution_range:10,variable:'x'})
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

  # def self.generate_one_sided_questions(number_of_questions=12,number_of_steps=1,solution_range=10,options={})
  #   questions = []
  #   number_of_questions.times do
  #     questions << self.generate_one_sided(number_of_steps,solution_range,options)
  #   end
  #   questions
  # end

  # def ==(linear_equation)
  #   left_side == linear_equation.left_side &&
  #   right_side == linear_equation.right_side &&
  #   solution == linear_equation.solution
  # end

  def convert_to_general_equation(variable_letter='x')
    equation_left = Expression.new(variable_letter,left_side)
    equation_right = Expression.new(right_side)
    Equation.new(equation_left,equation_right,{variable_letter => solution})
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

# p LinearEquation.generate(2,{steps:1,solution_range:10,variable:'x'})
