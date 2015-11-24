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
    return _subtraction(integer_range,fraction_range) if operation == 'subtract'
    return _multiplication(integer_range,fraction_range) if operation == 'multiply'
    return _division(integer_range,fraction_range) if operation == 'divide'
  end

  private

  def _addition(integer_range,fraction_range)
    fraction1 = random_fraction(integer_range,fraction_range)
    fraction2 = random_fraction(integer_range,fraction_range)
    {operator:'addition',fraction1:fraction1,fraction2:fraction2,
      solution:fraction1.add(fraction2)}
  end

  def _subtraction(integer_range,fraction_range)
    fraction1 = random_fraction(integer_range,fraction_range)
    while true
      fraction2 = random_fraction(integer_range,fraction_range)
      break if fraction2 < fraction1
    end
    {operator:'subtract',fraction1:fraction1,fraction2:fraction2,
      solution:fraction1.subtract(fraction2)}
  end

  def _multiplication(integer_range,fraction_range)
    fraction1 = random_fraction((integer_range*0.6).to_i,(fraction_range*0.8).to_i)
    fraction2 = random_fraction((integer_range*0.6).to_i,(fraction_range*0.8).to_i)
    {operator:'multiply',fraction1:fraction1,fraction2:fraction2,
      solution:fraction1.multiply(fraction2)}
  end

  def _division(integer_range,fraction_range)
    fraction1 = random_fraction((integer_range*0.6).to_i,(fraction_range*0.8).to_i)
    fraction2 = random_fraction((integer_range*0.6).to_i,(fraction_range*0.8).to_i)
    {operator:'divide',fraction1:fraction1,fraction2:fraction2,
      solution:fraction1.divide(fraction2)}
  end

end
