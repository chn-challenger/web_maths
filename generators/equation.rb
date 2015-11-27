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

  def solution_next_step
    self_copy = self.dup
    if self_copy.left_side.steps.count > 0
      steps_side = self_copy.left_side
      values_side = self_copy.right_side
    else
      steps_side = self_copy.right_side
      values_side = self_copy.left_side
    end
    if steps_side.steps.count > 0
      last_step = steps_side.steps.shift

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

  def generate_solution
    solution_equations = []
    first_equation = self.dup
    solution_equations << first_equation
    second_equation = first_equation.dup
    step = second_equation.left_side.steps.shift
    step.reverse
  end

end
