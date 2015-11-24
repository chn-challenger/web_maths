class Fraction

  attr_reader :integer, :numerator, :denominator

  def initialize(integer,numerator,denominator)
    @integer = integer
    @numerator = numerator
    @denominator = denominator
  end

  def simplify
    _divide_out_gcd
    _reduce_topheavy
    self
  end

  def ==(fraction)
    (integer == fraction.integer) && (numerator == fraction.numerator) &&
      (denominator == fraction.denominator)
  end

  def >(fraction)
    self_topheavy = self.mixed_to_topheavy
    fraction_topheavy = fraction.mixed_to_topheavy
    self_topheavy.numerator.to_f/self_topheavy.denominator > fraction_topheavy.numerator.to_f/fraction_topheavy.denominator
  end

  def <(fraction)
    !(self > fraction) && !(self.same_value?(fraction))
  end

  def same_value?(fraction)
    self.simplify
    fraction.simplify
    self == fraction
  end

  def mixed_to_topheavy
    new_numerator = numerator + integer * denominator
    Fraction.new(0,new_numerator,denominator)
  end

  def topheavy_to_mixed
    new_integer = numerator / denominator
    new_numerator = numerator - new_integer * denominator
    Fraction.new(new_integer,new_numerator,denominator)
  end

  def add(fraction)
    result_int_part = integer + fraction.integer
    result_denominator = denominator.lcm(fraction.denominator)
    result_numerator = numerator * (result_denominator/denominator) +
      fraction.numerator * (result_denominator/fraction.denominator)
    Fraction.new(result_int_part,result_numerator,result_denominator).simplify
  end

  def subtract(fraction)
    fraction = Fraction.new(-1*fraction.integer,-1*fraction.numerator,fraction.denominator)
    self.add(fraction)
  end

  def multiply(fraction)
    fraction1 = self.simplify.mixed_to_topheavy
    fraction2 = fraction.simplify.mixed_to_topheavy
    result_numerator = fraction1.numerator * fraction2.numerator
    result_denominator = fraction1.denominator * fraction2.denominator
    Fraction.new(0,result_numerator,result_denominator).simplify
  end

  def divide(fraction)
    fraction1 = self.simplify.mixed_to_topheavy
    fraction2 = fraction.simplify.mixed_to_topheavy
    fraction = Fraction.new(0,fraction2.denominator,fraction2.numerator)
    fraction1.multiply(fraction)
  end

  private

  def _reduce_topheavy
    extra_int_part = numerator / denominator
    @integer += extra_int_part
    @numerator -= denominator * extra_int_part
  end

  def _divide_out_gcd
    gcd = self.numerator.gcd(denominator)
    @numerator /= gcd
    @denominator /= gcd
  end

end
