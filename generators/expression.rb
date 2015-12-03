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
      if step.value.is_a?(Expression)
        step.value.steps << last_step
      else
        step.value *= last_step.value
      end
    end
    copy
  end

  def simplify
    copy = self.copy
    similar_steps = []
    i = 0
    (0...copy.steps.length - 1).each do |i|
      if _same_type?(copy.steps[i].operation, copy.steps[i+1].operation)
        p "first if"
        start_index ||= i
        end_index = i + 1
        p "======"
        p start_index
        p end_index
        p "======"
        # similar_steps << copy.steps.delete_at(i) if similar_steps.empty?
        # similar_steps << copy.steps.delete_at(i)
      else
        if !!start_index
          result = evaluate(0, copy.steps.slice!(start_index..end_index))
          if result > 0
            simplified_step = EquationStep.new(:add, result, :right)
          else
            simplified_step = EquationStep.new(:subtract, result.abs, :right)
          end
          copy.steps.insert(start_index, simplified_step)
          return copy
        end
      end
    end
  end

  def _same_type?(operation1, operation2)
    add_subtract = [:add, :subtract]
    (add_subtract.include?(operation1) && add_subtract.include?(operation2)) || (!add_subtract.include?(operation1) && !add_subtract.include?(operation2))
  end

end
#
# exp1 = Expression.new('y',[EquationStep.new(:multiply,3,:left)])
# exp2 = Expression.new('z',[EquationStep.new(:subtract,23,:left),EquationStep.new(:multiply,3,:left)])
# exp3 = Expression.new('x',[EquationStep.new(:multiply,3,:right),EquationStep.new(:subtract,exp2,:right),
#   EquationStep.new(:add,exp1,:right),EquationStep.new(:multiply,2,:left),
#   EquationStep.new(:subtract,11,:right)])
