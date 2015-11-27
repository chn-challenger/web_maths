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

  def generate_solution
    solution_equations = []
    first_equation = self.dup
    solution_equations << first_equation
    second_equation = first_equation.dup
    step = second_equation.left_side.steps.shift
    step.reverse


  end

end
