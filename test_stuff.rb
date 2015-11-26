# require './generators/fraction'

# p Fraction.new(1,2,3)
# f1 = Fraction.new(1,7,5)
# f2 = Fraction.new(1,7,5)
# p f1 == f2
#
#
#
#
# /Library/TeX/texbin/latex -src -interaction=nonstopmode %.tex
# /Library/TeX/texbin/pdflatex -synctex=1 -interaction=nonstopmode %.tex
# /Library/TeX/texbin/xelatex -synctex=1 -interaction=nonstopmode %.tex
# /Library/TeX/texbin/lualatex -synctex=1 -interaction=nonstopmode %.tex
# /Library/TeX/texbin/dvips -o %.ps %.dvi
# /Library/TeX/texbin/dvipng -T tight -D 120 %.dvi
# /Library/TeX/local/bin/ps2pdf %.ps
# /Library/TeX/local/bin/dvipdf %.dvi
# /Library/TeX/texbin/bibtex %.aux
# /Library/TeX/texbin/bibtex8 %.aux
# /Library/TeX/texbin/biber %
# /Library/TeX/texbin/makeindex %.idx
# /Library/TeX/texbin/texindy %.idx
# sh -c "PATH=$PATH:/Library/TeX/texbin/; makeglossaries %"
# /Library/TeX/texbin/mpost -interaction=nonstopmode ?me)
# /Library/TeX/texbin/asy ?m*.asy
# /usr/local/bin/gs "?am.ps"
# latexmk -pdf -silent -latexoption="-synctex=1" %
#


#old fraction_subtract
# self.simplify.mixed_to_topheavy
# fraction.simplify.mixed_to_topheavy
# result_denominator = denominator.lcm(fraction.denominator)
# result_numerator = numerator * (result_denominator/denominator) -
#   fraction.numerator * (result_denominator/fraction.denominator)
# Fraction.new(0,result_numerator,result_denominator).simplify


#
# filename = 'testfile.txt'
# file_content = 'totally new\\\ stuff'
# file_content += '\\\hihihi'
# puts file_content
#
#
# require './generators/fraction'
# require './generators/serial'
# include SerialNumber
#
# class LatexPrinter
#
#   QUESTION_AND_NUMBER_SPACING = 15
#   LINE_SPACING = 2
#   TITLE_CONTENT_SPACE = 10
#   MAX_QUESTIONS_PER_ROW = 4  #used for much later
#
#   HEADERS = "\\documentclass{article}\n"\
#     "\\usepackage[math]{iwona}\n"\
#     "\\usepackage[fleqn]{amsmath}\n"\
#     "\\usepackage{scrextend}\n"\
#     "\\changefontsizes[20pt]{17pt}\n"\
#     "\\usepackage[margin=0.7in]{geometry}\n"\
#     "\\pagenumbering{gobble}\n"\
#     "\\begin{document}\n"
#
#   def self.fraction_question(question)
#     question_latex = self._latex_fraction(question[:fraction1]) +
#       self._latex_sign(question[:operation]) + self._latex_fraction(question[:fraction2])
#     solution_latex = self._latex_fraction(question[:solution])
#     {question:question_latex,solution:solution_latex}
#   end
#
#   def self.fraction_sheet_content(questions_per_row=2,number_of_rows=5,operation=['add'],
#     integer_range=10,fraction_range=10)
#
#     questions = Fraction.worksheet_questions(questions_per_row * number_of_rows,
#       operation,integer_range,fraction_range)
#     question_number = 1
#
#     latex_questions = ''
#     latex_solutions = ''
#
#     for i in 1..number_of_rows
#       questions_per_row.times do
#         latex_questions += '&' if question_number%questions_per_row != 1
#         latex_questions += "&#{question_number}.\\hspace{#{QUESTION_AND_NUMBER_SPACING}pt}"
#         latex_questions += self.fraction_question(questions[question_number-1])[:question]
#
#         latex_solutions += '&' if question_number%questions_per_row != 1
#         latex_solutions += "&#{question_number}.\\hspace{#{QUESTION_AND_NUMBER_SPACING}pt}"
#         latex_solutions += self.fraction_question(questions[question_number-1])[:solution]
#
#         question_number += 1
#       end
#       latex_questions += '\\\[2em]' if i != number_of_rows
#       latex_questions += "\n"
#
#       latex_solutions += '\\\[2em]' if i != number_of_rows
#       latex_solutions += "\n"
#     end
#     {questions: latex_questions,solutions: latex_solutions}
#   end
#
#   def self.fraction_sheet(title='',questions_per_row=2,number_of_rows=5,operation=['add','subtract','multiply','divide'],
#     integer_range=10,fraction_range=10)
#
#     content = self.fraction_sheet_content(questions_per_row,number_of_rows,operation,integer_range,fraction_range)
#
#     latex_questions_sheet = HEADERS
#     latex_questions_sheet += "\\section*{\\centerline{Fraction Worksheet #{title}}}\n\\vspace{#{TITLE_CONTENT_SPACE} mm}\n\\begin{align*}\n"
#     latex_questions_sheet += content[:questions] + "\\end{align*}\n\\end{document}"
#
#     latex_solutions_sheet = HEADERS
#     latex_solutions_sheet += "\\section*{\\centerline{Fraction Worksheet #{title} Solutions}}\n\\vspace{#{TITLE_CONTENT_SPACE} mm}\n\\begin{align*}\n"
#     latex_solutions_sheet += content[:solutions] + "\\end{align*}\n\\end{document}"
#
#     {questions_sheet:latex_questions_sheet,solutions_sheet:latex_solutions_sheet}
#
#   end
#
#   private
#
#   def self._latex_fraction(fraction)
#     result = fraction.integer == 0 ? "" : "#{fraction.integer}"
#     result += "\\frac{#{fraction.numerator}}{#{fraction.denominator}}"
#   end
#
#   def self._latex_sign(operation)
#     sign = case operation
#       when 'addition' then  '+'
#       when 'subtract' then  '-'
#       when 'multiply' then  '\times'
#       when 'divide' then '\div'
#       else '+'
#     end
#   end
#
# end




private

def self._current_step_value(current_step_operation,current_step_range,current_step_orientation,current_value)
  if current_step_operation == :subtract && current_step_orientation == :left
    current_step_value = current_value + rand(2..current_step_range)
  end
  if current_step_operation == :subtract && current_step_orientation == :right
    current_step_range = [current_value,current_step_range].min - 1
  end
  if current_step_operation == :divide && current_step_orientation == :left
    current_step_value = current_value * rand(2..current_step_range)
  end
  if current_step_operation == :divide && current_step_orientation == :right
    choices = self._divisors_of(current_value, current_step_range)
    if choices.count == 0
      current_step_orientation = :left
      current_step_value = current_value * rand(2..current_step_range)
    else
      current_step_value = choices.sample
    end
  end
  current_step_value ||= rand(2..current_step_range)
  return current_step_value
end

def self._next_step(left_side,current_value,options)
  current_step_operation = self._current_step_operation(left_side)
  current_step_orientation = ORIENTATIONS.sample
  current_step_range = options[current_step_operation] ?
    options[current_step_operation] : DEFAULT_RANGE[current_step_operation]
  current_step_value = self._current_step_value(current_step_operation,current_step_range,current_step_orientation,current_value)
  # if current_step_operation == :subtract && current_step_orientation == :left
  #   current_step_value = current_value + rand(2..current_step_range)
  # end
  # if current_step_operation == :subtract && current_step_orientation == :right
  #   current_step_range = [current_value,current_step_range].min - 1
  # end
  # if current_step_operation == :divide && current_step_orientation == :left
  #   current_step_value = current_value * rand(2..current_step_range)
  # end
  # if current_step_operation == :divide && current_step_orientation == :right
  #   choices = self._divisors_of(current_value, current_step_range)
  #   if choices.count == 0
  #     current_step_orientation = :left
  #     current_step_value = current_value * rand(2..current_step_range)
  #   else
  #     current_step_value = choices.sample
  #   end
  # end
  # current_step_value ||= rand(2..current_step_range)

  EquationStep.new(current_step_operation,current_step_value,current_step_orientation)
end

def self._current_step_operation(left_side)
  if left_side.count > 0
    if MULTIPLY_DIVIDE.include?(left_side.last.operation)
      current_step_operation = ADD_SUBTRACT.sample
    else
      current_step_operation = MULTIPLY_DIVIDE.sample
    end
  else
    current_step_operation = [MULTIPLY_DIVIDE,ADD_SUBTRACT].sample.sample
  end
end

def self._divisors_of(number,max)
  range = number < 0 ? number * -1 : number
  (1..range).select { |n| range % n == 0 && n != 1 && n <= max}
end

end



# def self._next_step(left_side,current_value,options)
#   multiply_divide = [:multiply,:divide]
#   add_subtract = [:add,:subtract]
#   orientations = [:left,:right]
#
#   if left_side.count > 0
#     if multiply_divide.include?(left_side.last.operation)
#       current_step_operation = add_subtract.sample
#     else
#       current_step_operation = multiply_divide.sample
#     end
#   else
#     current_step_operation = [multiply_divide,add_subtract].sample.sample
#   end
#
#   current_step_orientation = orientations.sample
#
#   current_step_range = options[current_step_operation] ? options[current_step_operation] : DEFAULT_RANGE[current_step_operation]
#
#   if current_step_operation == :subtract && current_step_orientation == :left
#     current_step_value = current_value + rand(2..current_step_range)
#   end
#   if current_step_operation == :subtract && current_step_orientation == :right
#     current_step_range = [current_value,current_step_range].min - 1
#   end
#   if current_step_operation == :divide && current_step_orientation == :left
#     current_step_value = current_value * rand(2..current_step_range)
#   end
#   if current_step_operation == :divide && current_step_orientation == :right
#     choices = self._divisors_of(current_value, current_step_range)
#     if choices.count == 0
#       current_step_orientation = :left
#       current_step_value = current_value * rand(2..current_step_range)
#     else
#       current_step_value = choices.sample
#     end
#   end
#   current_step_value ||= rand(2..current_step_range)
#
#   EquationStep.new(current_step_operation,current_step_value,current_step_orientation)
# end



  private

  def self._current_step_value(current_step_operation,current_step_range,current_step_orientation,current_value)
    if current_step_operation == :subtract && current_step_orientation == :left
      current_step_value = current_value + rand(2..current_step_range)
    end
    if current_step_operation == :subtract && current_step_orientation == :right
      current_step_range = [current_value,current_step_range].min - 1
    end
    if current_step_operation == :divide && current_step_orientation == :left
      current_step_value = current_value * rand(2..current_step_range)
    end
    if current_step_operation == :divide && current_step_orientation == :right
      choices = self._divisors_of(current_value, current_step_range)
      if choices.count == 0
        current_step_orientation = :left
        current_step_value = current_value * rand(2..current_step_range)
      else
        current_step_value = choices.sample
      end
    end
    current_step_value ||= rand(2..current_step_range)
    return current_step_value
  end

  def self._next_step(left_side,current_value,options)
    next_step = EquationStep.new()
    current_step_operation = self._current_step_operation(left_side)
    next_step.operation = current_step_operation
    current_step_orientation = ORIENTATIONS.sample
    next_step.orientation = current_step_orientation
    current_step_range = options[current_step_operation] ?
      options[current_step_operation] : DEFAULT_RANGE[current_step_operation]
    current_step_value = self._current_step_value(current_step_operation,current_step_range,current_step_orientation,current_value)
    next_step.value = current_step_value
    # if current_step_operation == :subtract && current_step_orientation == :left
    #   current_step_value = current_value + rand(2..current_step_range)
    # end
    # if current_step_operation == :subtract && current_step_orientation == :right
    #   current_step_range = [current_value,current_step_range].min - 1
    # end
    # if current_step_operation == :divide && current_step_orientation == :left
    #   current_step_value = current_value * rand(2..current_step_range)
    # end
    # if current_step_operation == :divide && current_step_orientation == :right
    #   choices = self._divisors_of(current_value, current_step_range)
    #   if choices.count == 0
    #     current_step_orientation = :left
    #     current_step_value = current_value * rand(2..current_step_range)
    #   else
    #     current_step_value = choices.sample
    #   end
    # end
    # current_step_value ||= rand(2..current_step_range)


    return next_step
    # EquationStep.new(current_step_operation,current_step_value,current_step_orientation)
  end

  def self._current_step_operation(left_side)
    if left_side.count > 0
      if MULTIPLY_DIVIDE.include?(left_side.last.operation)
        current_step_operation = ADD_SUBTRACT.sample
      else
        current_step_operation = MULTIPLY_DIVIDE.sample
      end
    else
      current_step_operation = [MULTIPLY_DIVIDE,ADD_SUBTRACT].sample.sample
    end
  end

  def self._divisors_of(number,max)
    range = number < 0 ? number * -1 : number
    (1..range).select { |n| range % n == 0 && n != 1 && n <= max}
  end

end



# def self._next_step(left_side,current_value,options)
#   multiply_divide = [:multiply,:divide]
#   add_subtract = [:add,:subtract]
#   orientations = [:left,:right]
#
#   if left_side.count > 0
#     if multiply_divide.include?(left_side.last.operation)
#       current_step_operation = add_subtract.sample
#     else
#       current_step_operation = multiply_divide.sample
#     end
#   else
#     current_step_operation = [multiply_divide,add_subtract].sample.sample
#   end
#
#   current_step_orientation = orientations.sample
#
#   current_step_range = options[current_step_operation] ? options[current_step_operation] : DEFAULT_RANGE[current_step_operation]
#
#   if current_step_operation == :subtract && current_step_orientation == :left
#     current_step_value = current_value + rand(2..current_step_range)
#   end
#   if current_step_operation == :subtract && current_step_orientation == :right
#     current_step_range = [current_value,current_step_range].min - 1
#   end
#   if current_step_operation == :divide && current_step_orientation == :left
#     current_step_value = current_value * rand(2..current_step_range)
#   end
#   if current_step_operation == :divide && current_step_orientation == :right
#     choices = self._divisors_of(current_value, current_step_range)
#     if choices.count == 0
#       current_step_orientation = :left
#       current_step_value = current_value * rand(2..current_step_range)
#     else
#       current_step_value = choices.sample
#     end
#   end
#   current_step_value ||= rand(2..current_step_range)
#
#   EquationStep.new(current_step_operation,current_step_value,current_step_orientation)
# end
