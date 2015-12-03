require './generators/linear_equation'

module QuestionGenerator

  def generate(number_of_questions=2,klass=LinearEquation,options={steps:2,solution_range:10,variable:'x'})
    questions = []
    number_of_questions.times {questions << klass.generate(options)}
    questions
  end

  def generate_solutions(questions)
    solutions = []
    questions.each do |question|
      solutions << question.generate_solution
    end
    solutions
  end

end

# include QuestionGenerator
#
# questions =  generate(4)
#
# p generate_solutions(questions)
