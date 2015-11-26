require './generators/equation_step'

class LinearEquation

  DEFAULT_RANGE = {add:50,subtract:50,multiply:9,divide:9}

  attr_reader :left_side, :right_side, :solution

  def initialize(left_side,right_side,solution)
    @left_side = left_side
    @right_side = right_side
    @solution = solution
  end

  def self.generate_one_sided(steps=1,solution_range=10,options={})



    solution = rand(1..solution_range)

    multiply_divide = [:multiply,:divide]
    add_subtract = [:add,:subtract]
    orientations = [:left,:right]


    left_side = []
    current_step = 1
    current_left_side_value = solution

    while true
      if multiply_divide.include?(left_side.last.operation)
        current_step_operation = add_subtract.sample
      else
        current_step_operation = multiply_divide.sample
      end

      current_step_orientation = orientations.sample

      range = options[current_step_operation] ? options[current_step_operation] : DEFAULT_RANGE[current_step_operation]
      current_step_value = 2

      left_side << EquationStep.new(current_step_operation,current_step_value,current_step_orientation)

      current_left_side_value = self.evaluate(starting_value,steps)

      current_step += 1
      break if current_step > steps
    end

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
