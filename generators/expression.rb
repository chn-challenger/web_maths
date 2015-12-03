require './generators/equation_step'
require './generators/evaluate'

include Evaluate

class Expression

  attr_accessor :initial_value, :steps

  def initialize(initial_value=0,steps=[])
    @initial_value = initial_value
    @steps = steps
  end

  def ==(expression)
    initial_value == expression.initial_value && steps == expression.steps
  end

  def copy
    new_steps = []
    steps.each {|step| new_steps << step.copy}
    copy_initial_value = initial_value.is_a?(String) ? initial_value.dup : initial_value
    self.class.new(copy_initial_value,new_steps)
  end

  def evaluate_next_step
    copy = self.copy
    return copy if initial_value.is_a?(String) || steps == []
    next_step = copy.steps.shift
    copy.initial_value = evaluate(copy.initial_value,[next_step])
    copy
  end

  def expand_bracket
    copy = self.copy
    last_step = copy.steps.pop
    copy.initial_value = Expression.new(copy.initial_value,[last_step])
    copy.steps.each do |step|
      step.value *= last_step.value
    end
    copy
  end


end
#
# exp1 = Expression.new('y',[EquationStep.new(:multiply,3,:left)])
# exp2 = Expression.new('z',[EquationStep.new(:subtract,23,:left),EquationStep.new(:multiply,3,:left)])
# exp3 = Expression.new('x',[EquationStep.new(:multiply,3,:right),EquationStep.new(:subtract,exp2,:right),
#   EquationStep.new(:add,exp1,:right),EquationStep.new(:multiply,2,:left),
#   EquationStep.new(:subtract,11,:right)])
