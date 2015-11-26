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

  def normalize
    @orientation = :left if operation == :multiply
    return self
  end

end
