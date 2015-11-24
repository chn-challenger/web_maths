require './generators/fraction'

# p Fraction.new(1,2,3)
f1 = Fraction.new(1,7,5)
f2 = Fraction.new(1,7,5)
p f1 == f2










#old fraction_subtract
# self.simplify.mixed_to_topheavy
# fraction.simplify.mixed_to_topheavy
# result_denominator = denominator.lcm(fraction.denominator)
# result_numerator = numerator * (result_denominator/denominator) -
#   fraction.numerator * (result_denominator/fraction.denominator)
# Fraction.new(0,result_numerator,result_denominator).simplify
