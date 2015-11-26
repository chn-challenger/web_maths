require './generators/equation_step'
require './generators/evaluate'

include Evaluate

class LinearEquation

  DEFAULT_RANGE = {add:50,subtract:50,multiply:9,divide:9}

  attr_reader :left_side, :right_side, :solution

  def initialize(left_side,right_side,solution)
    @left_side = left_side
    @right_side = right_side
    @solution = solution
  end

  def self.generate_one_sided(number_of_steps=1,solution_range=10,options={})
    solution = rand(2..solution_range)
    left_side = []
    current_value = solution
    number_of_steps.times do
        current_step = self._next_step(left_side,current_value,options)
        current_value = evaluate(current_value,[current_step])
        left_side << current_step
    end
    LinearEquation.new(left_side,current_value,solution)
  end

  private

  def self._next_step(left_side,current_value,options)
    multiply_divide = [:multiply,:divide]
    add_subtract = [:add,:subtract]
    orientations = [:left,:right]

    if left_side.count > 0
      if multiply_divide.include?(left_side.last.operation)
        current_step_operation = add_subtract.sample
      else
        current_step_operation = multiply_divide.sample
      end
    else
      current_step_operation = [multiply_divide,add_subtract].sample.sample
    end

    current_step_orientation = orientations.sample

    current_step_range = options[current_step_operation] ? options[current_step_operation] : DEFAULT_RANGE[current_step_operation]

    if current_step_operation == :subtract && current_step_orientation == :left
      current_step_value = current_value + rand(2..current_step_range)
    end
    if current_step_operation == :divide && current_step_orientation == :left
      current_step_value = current_value * rand(2..current_step_range)
    end
    if current_step_operation == :divide && current_step_orientation == :right
      choices = self._divisors_of(current_value, current_step_range)
      current_step_value = choices.sample
    end
    current_step_value ||= rand(2..current_step_range)

    EquationStep.new(current_step_operation,current_step_value,current_step_orientation)
  end

  def self._divisors_of(number,max)
    range = number < 0 ? number * -1 : number
    (1..range).select { |n| range % n == 0 && n != 1 && n <= max}
  end

end
