require './generators/fraction'

module Questions

  def fraction_question(operation='addition',integer_range=10,fraction_range=10)
    if operation == 'addition'
        fraction1 = random_fraction(integer_range,fraction_range)
        fraction2 = random_fraction(integer_range,fraction_range)
        solution = fraction1.add(fraction2)
        return {operator: 'addition',fraction1: fraction1,fraction2: fraction2,solution: solution}
    end
  end

  def random_fraction(integer_range=10,fraction_range=10)
    integer = rand(0..integer_range)
    denominator = rand(2..fraction_range)
    numerator = rand(1...denominator)
    Fraction.new(integer,numerator,denominator).simplify
  end


end
