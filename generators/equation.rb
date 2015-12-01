require './generators/expression'

class Equation

  attr_accessor :left_side, :right_side, :solution

  def initialize(left_side=Expression.new,right_side=Expression.new,solution={})
    @left_side = left_side
    @right_side = right_side
    @solution = solution
  end

  def ==(equation)
    left_side == equation.left_side && right_side == equation.right_side
  end

  def solution_next_step_old
    self_copy = self.dup
    if self_copy.left_side.steps.count > 0
      steps_side = self_copy.left_side
      values_side = self_copy.right_side
    else
      steps_side = self_copy.right_side
      values_side = self_copy.left_side
    end
    if steps_side.steps.count > 0
      last_step = steps_side.steps.pop

      side_swap = true if last_step.orientation == :left && (last_step.operation == :divide || last_step.operation == :subtract )

      reverse_of_last_step = last_step.reverse
      values_side.steps << reverse_of_last_step
    end
    self_copy

    self_copy_copy = self_copy.dup
    if self_copy_copy.left_side.initial_value.is_a?(Integer)
      self_copy_copy.left_side = self_copy_copy.left_side.evaluate_next_step
    else
      self_copy_copy.right_side = self_copy_copy.right_side.evaluate_next_step
    end

    if !!side_swap
      self_copy.left_side, self_copy.right_side = self_copy.right_side, self_copy.left_side
      self_copy_copy.left_side, self_copy_copy.right_side = self_copy_copy.right_side, self_copy_copy.left_side
    end

    [self_copy,self_copy_copy]
  end

  def solution_next_step
    # self_copy = self.dup
    left_initial_value = left_side.initial_value
    left_steps = left_side.steps.dup
    right_initial_value = right_side.initial_value
    right_steps = right_side.steps.dup

    left_copy = Expression.new(left_initial_value,left_steps)
    right_copy = Expression.new(right_initial_value,right_steps)
    solution_copy = solution.dup
    self_copy = Equation.new(left_copy,right_copy,solution_copy)
    # self_copy = Equation.new(left_side,right_side,solution)
    if (left_side.initial_value.is_a?(Integer) && left_side.steps.count > 0) || (right_side.initial_value.is_a?(Integer) && right_side.steps.count > 0)
      return self_copy._valuation_next_step
    end
    if (left_side.initial_value.is_a?(String) && left_side.steps.count > 0) || (right_side.initial_value.is_a?(String) && right_side.steps.count > 0)

      puts "==================BEFORE==================="
      p self
      last_step = self_copy.left_side.steps.pop
      puts "=====================AFTER===================="
      p self
      reverse_of_last_step = last_step.reverse
      self_copy.right_side.steps << reverse_of_last_step
      # puts "=====================AFTER===================="
      # p self
      return self_copy

      # return self_copy._reverse_last_step
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

  def generate_solution
    solution_equations = []
    equation = self.dup
    # solution_equations << self
    puts
    puts '%%%%%%%%%%%%%%%%%SOLUTION NEXT STEP%%%%%%%%%%%%%%%%%%%%%%'
    p equation
    puts '%%%%%%%%%%%%%%%%%END NEXT STEP%%%%%%%%%%%%%%%%%%%%%%'
    puts
    solution_equations << equation
    while true
      equation = equation.solution_next_step
      puts
      puts '%%%%%%%%%%%%%%%%%SOLUTION NEXT STEP%%%%%%%%%%%%%%%%%%%%%%'
      p equation
      puts '%%%%%%%%%%%%%%%%%END NEXT STEP%%%%%%%%%%%%%%%%%%%%%%'
      puts
      solution_equations << equation
      break if equation.left_side.steps.count == 0 && equation.right_side.steps.count == 0
    end
    puts
    puts
    puts '%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'
    puts '%%%%%%%%%%%%%%%%%FINAL SOLUTIONS%%%%%%%%%%%%%%%%%%%%%%'
    p solution_equations
    puts '%%%%%%%%%%%%%%%%%END FINAL SOLUTIONS%%%%%%%%%%%%%%%%%%%%%%'
    puts '%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'
    puts
    puts
    solution_equations
  end

end
