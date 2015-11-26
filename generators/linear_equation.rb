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

    multiply_divide = [:multiply,:divide]
    add_subtract = [:add,:subtract]
    orientations = [:left,:right]

    left_side = []
    step_number = 1
    current_value = solution

    #step1
    current_step_operation = [multiply_divide,add_subtract].sample.sample
    current_step_orientation = orientations.sample
    current_step_range = options[current_step_operation] ? options[current_step_operation] : DEFAULT_RANGE[current_step_operation]
    #set current_step_value - dealing with cases of left subtraction and division
    current_step_value = nil
    if current_step_operation == :subtract && current_step_orientation == :left
      current_step_value = current_value + rand(2..current_step_range)
    end
    if current_step_operation == :divide && current_step_orientation == :left
      current_step_value = current_value * rand(2..current_step_range)
    end
    if current_step_operation == :divide && current_step_orientation == :right
      choices = self.divisors_of(current_value, current_step_range)
      current_step_value = choices.sample
    end
    current_step_value ||= rand(2..current_step_range)
    #make the step
    current_step = EquationStep.new(current_step_operation,current_step_value,current_step_orientation)
    #find the current_value after this step
    current_value = evaluate(current_value,[current_step])
    #update both sides
    left_side << current_step
    #
    while step_number < number_of_steps
      #operation must altenate from previous
      if multiply_divide.include?(left_side.last.operation)
        current_step_operation = add_subtract.sample
      else
        current_step_operation = multiply_divide.sample
      end
      current_step_orientation = orientations.sample
      current_step_range = options[current_step_operation] ? options[current_step_operation] : DEFAULT_RANGE[current_step_operation]
      #set current_step_value - dealing with cases of left subtraction and division
      current_step_value = nil
      if current_step_operation == :subtract && current_step_orientation == :left
        current_step_value = current_value + rand(2..current_step_range)
      end
      if current_step_operation == :divide && current_step_orientation == :left
        current_step_value = current_value * rand(2..current_step_range)
      end
      if current_step_operation == :divide && current_step_orientation == :right
        choices = self.divisors_of(current_value, current_step_range)
        current_step_value = choices.sample
      end
      current_step_value ||= rand(2..current_step_range)
      #make the step
      current_step = EquationStep.new(current_step_operation,current_step_value,current_step_orientation)
      #find the current_value after this step
      current_value = evaluate(current_value,[current_step])
      #update both sides
      left_side << current_step
      #update step_number
      step_number += 1
    end

    right_side = current_value
    return LinearEquation.new(left_side,right_side,solution)
  end

  private

  def self.divisors_of(number,max)
    range = number < 0 ? number * -1 : number
    (1..range).select { |n| range % n == 0 && n != 1 && n <= max}
  end

end
