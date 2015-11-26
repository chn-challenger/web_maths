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

end
