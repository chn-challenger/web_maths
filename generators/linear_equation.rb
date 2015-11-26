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

  def self.generate_one_sided(number_of_steps=1,solution_range=20,options={})

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
    if current_step_operation == :subtract && current_step_orientation == :left
      current_step_value = current_value + rand(2..current_step_range)
    end
    if current_step_operation == :divide && current_step_orientation == :left
      current_step_value = current_value * rand(2..current_step_range)
    end
    current_step_value ||= rand(2..current_step_range)
    #make the step
    current_step = EquationStep.new(current_step_operation,current_step_value,current_step_orientation)
    #find the current_value after this step
    current_value = evaluate(current_value,[current_step])
    #update both sides
    left_side << current_step
    right_side = current_value
    #
    while step_number < number_of_steps
      if multiply_divide.include?(left_side.last.operation)
        current_step_operation = add_subtract.sample
      else
        current_step_operation = multiply_divide.sample
      end

      current_step_orientation = orientations.sample

    end
    # while true
    #   if multiply_divide.include?(left_side.last.operation)
    #     current_step_operation = add_subtract.sample
    #   else
    #     current_step_operation = multiply_divide.sample
    #   end
    #
    #   current_step_orientation = orientations.sample
    #
    #   range = options[current_step_operation] ? options[current_step_operation] : DEFAULT_RANGE[current_step_operation]
    #   current_step_value = 2
    #
    #   left_side << EquationStep.new(current_step_operation,current_step_value,current_step_orientation)
    #
    #   current_left_side_value = self.evaluate(starting_value,steps)
    #
    #   current_step += 1
    #   break if current_step > steps
    # end
    return LinearEquation.new(left_side,right_side,solution)
  end

  def self.determine_range(operation,orientation,options)
    if operation == :multiply
      if options[:multiplication_range]
        return options[:multiplication_range]
      else
        return 9 #default multiply range
      end
    end

    if operation == :divide
      if options[:division_range]
        return options[:division_range]
      else
        return 9 #default right division range
      end
    end
  end

end

# p LinearEquation.generate_one_sided()
# p [1,2,5,3,21].last
