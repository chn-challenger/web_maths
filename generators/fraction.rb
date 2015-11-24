class Fraction

  attr_reader :integer, :numerator, :denominator

  def initialize(integer,numerator,denominator)
    @integer = integer
    @numerator = numerator
    @denominator = denominator
  end

  def simplify
    divide_out_gcd
    reduce_topheavy
    self
  end

  def ==(fraction)
    (integer == fraction.integer) && (numerator == fraction.numerator) &&
      (denominator == fraction.denominator)
  end

  def same_value?(fraction)
    self.simplify
    fraction.simplify
    self == fraction
  end

  def mixed_to_topheavy
    @numerator += integer * denominator
    @integer = 0
  end

  def topheavy_to_mixed
    @integer = numerator / denominator
    @numerator -= integer * denominator
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
    self.simplify.mixed_to_topheavy
    fraction.simplify.mixed_to_topheavy
    result_numerator = numerator * fraction.numerator
    result_denominator = denominator * fraction.denominator
    Fraction.new(0,result_numerator,result_denominator).simplify
  end

  def divide(fraction)
    self.simplify.mixed_to_topheavy
    fraction.simplify.mixed_to_topheavy
    fraction = Fraction.new(0,fraction.denominator,fraction.numerator)
    self.multiply(fraction)
  end

  private

  def reduce_topheavy
    extra_int_part = numerator / denominator
    @integer += extra_int_part
    @numerator -= denominator * extra_int_part
  end

  def divide_out_gcd
    gcd = self.numerator.gcd(denominator)
    @numerator /= gcd
    @denominator /= gcd
  end

end
