require './generators/equation_step'

module Evaluate

  def evaluate(starting_value,steps)
    result = starting_value
    steps.each do |step|
      result = evaluate_one_step(result,step)
    end
    return result
  end

  def evaluate_one_step(starting_value,step)
    return starting_value + step.value if step.operation == :add
    return starting_value * step.value if step.operation == :multiply
    return starting_value - step.value if step.operation == :subtract && step.orientation == :right
    return starting_value / step.value if step.operation == :divide && step.orientation == :right
    return step.value - starting_value if step.operation == :subtract && step.orientation == :left
    return step.value / starting_value if step.operation == :divide && step.orientation == :left
  end

end

include Evaluate


starting_value = 7
s1 = EquationStep.new(:add,11)
s2 = EquationStep.new(:multiply,2)
s3 = EquationStep.new(:divide,36,:left)
p evaluate(starting_value,[s1,s2,s3])
