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
    Expression.new(copy_initial_value,new_steps)
  end

  def evaluate_next_step
    return Expression.new(initial_value,steps) if initial_value.is_a?(String) || steps == []
    current_steps = steps.dup
    next_step = current_steps.shift
    new_initial_value = evaluate(initial_value,[next_step])
    Expression.new(new_initial_value,current_steps)
  end

end
