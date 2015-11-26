class EquationStep

  attr_reader :operation, :value, :orientation

  def initialize(operation,value,orientation=:right)
    @operation = operation
    @value = value
    if operation == :multiply
      @orientation = :left
    else
      @orientation = orientation
    end
  end

  def ==(equation_step)
    (operation == equation_step.operation) && (value == equation_step.value) && (orientation == equation_step.orientation)
  end

end
