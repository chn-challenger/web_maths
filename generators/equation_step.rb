class EquationStep

  attr_accessor :operation, :value, :orientation

  def initialize(operation=nil,value=nil,orientation=nil)
    @operation = operation
    @value = value
    @orientation = orientation
  end

  def ==(equation_step)
    (operation == equation_step.operation) && (value == equation_step.value) && (orientation == equation_step.orientation)
  end

  def copy
    EquationStep.new(operation,value,orientation)
  end

  def normalize
    @orientation = :left if operation == :multiply
    return self
  end

  def reverse
    return self.dup if orientation == :left && (operation == :subtract || operation == :divide)
    return EquationStep.new(:subtract,value,:right) if operation == :add
    return EquationStep.new(:divide,value,:right) if operation == :multiply
    return EquationStep.new(:add,value,:right) if operation == :subtract && orientation == :right
    return EquationStep.new(:multiply,value,:right) if operation == :divide && orientation == :right
  end

end
