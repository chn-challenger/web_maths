require './generators/fraction'

module Questions

  def fraction_question
    {operator: 'addition',fraction1: Fraction.new(1,2,3), fraction2: Fraction.new(2,4,5), solution: Fraction.new(4,7,15)}
  end

end
