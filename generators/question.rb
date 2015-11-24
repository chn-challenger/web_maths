require './generators/fraction'

module Questions

  def random_fraction(integer_range=10,fraction_range=10)
    integer = rand(0..integer_range)
    denominator = rand(2..fraction_range)
    numerator = rand(1...denominator)
    Fraction.new(integer,numerator,denominator).simplify
  end

  def fraction_question(operation='addition',integer_range=10,fraction_range=10)
    return _addition(integer_range,fraction_range) if operation == 'addition'
    return _subtract(integer_range,fraction_range) if operation == 'subtract'
  end

  private

  def _addition(integer_range,fraction_range)
    fraction1 = random_fraction(integer_range,fraction_range)
    fraction2 = random_fraction(integer_range,fraction_range)
    {operator: 'addition',fraction1: fraction1,fraction2: fraction2,
      solution: fraction1.add(fraction2)}
  end

  def _subtract(integer_range,fraction_range)
    fraction1 = random_fraction(integer_range,fraction_range)
    while true
      fraction2 = random_fraction(integer_range,fraction_range)
      break if fraction2 < fraction1
    end
    {operator: 'subtract',fraction1: fraction1,fraction2: fraction2,
      solution: fraction1.subtract(fraction2)}
  end

end
