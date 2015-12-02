require './generators/expression'

class Equation

  attr_accessor :left_side, :right_side, :solution

  def initialize(left_side=Expression.new,right_side=Expression.new,solution={})
    @left_side = left_side
    @right_side = right_side
    @solution = solution
  end

  def ==(equation)
    left_side == equation.left_side && right_side == equation.right_side &&
      solution == equation.solution
  end

  def copy
    new_left_side = left_side.copy
    new_right_side = right_side.copy
    new_solution = solution.dup
    self.class.new(new_left_side, new_right_side, new_solution)
  end

end
