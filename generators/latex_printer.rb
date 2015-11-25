require './generators/fraction'

class LatexPrinter

  QUESTION_AND_NUMBER_SPACING = 15
  LINE_SPACING = 2
  TITLE_CONTENT_SPACE = 10
  MAX_QUESTIONS_PER_ROW = 4  #used for much later

  HEADERS = "\\documentclass{article}\n"\
    "\\usepackage[math]{iwona}\n"\
    "\\usepackage[fleqn]{amsmath}\n"\
    "\\usepackage{scrextend}\n"\
    "\\changefontsizes[20pt]{17pt}\n"\
    "\\usepackage[margin=0.7in]{geometry}\n"\
    "\\pagenumbering{gobble}\n"\
    "\\begin{document}\n"

  def self.fraction_question(question)
    question_latex = self._latex_fraction(question[:fraction1]) +
      self._latex_sign(question[:operation]) + self._latex_fraction(question[:fraction2])
    solution_latex = self._latex_fraction(question[:solution])
    {question:question_latex,solution:solution_latex}
  end

  def self.fraction_sheet_content(questions_per_row=2,number_of_rows=5,operation=['add'],
    integer_range=10,fraction_range=10)

    questions = Fraction.worksheet_questions(questions_per_row * number_of_rows,
      operation,integer_range,fraction_range)
    question_number = 1

    latex_questions = ''
    latex_solutions = ''

    for i in 1..number_of_rows
      questions_per_row.times do
        latex_questions += '&' if question_number%questions_per_row != 1
        latex_questions += "&#{question_number}.\\hspace{#{QUESTION_AND_NUMBER_SPACING}pt}"
        latex_questions += self.fraction_question(questions[question_number-1])[:question]

        latex_solutions += '&' if question_number%questions_per_row != 1
        latex_solutions += "&#{question_number}.\\hspace{#{QUESTION_AND_NUMBER_SPACING}pt}"
        latex_solutions += self.fraction_question(questions[question_number-1])[:solution]

        question_number += 1
      end
      latex_questions += '\\\[2em]' if i != number_of_rows
      latex_questions += "\n"

      latex_solutions += '\\\[2em]' if i != number_of_rows
      latex_solutions += "\n"
    end
    {questions: latex_questions,solutions: latex_solutions}
  end

  def self.fraction_sheet(title='',questions_per_row=2,number_of_rows=5,operation=['add','subtract','multiply','divide'],
    integer_range=10,fraction_range=10)
    # latex_questions_sheet = HEADERS
    # latex_questions_sheet += "\\section*{\\centerline{Fraction Worksheet #{title}}}\n\\vspace{#{TITLE_CONTENT_SPACE} mm}\n\\begin{align*}\n"
    # content = self.fraction_sheet_content(questions_per_row,number_of_rows,operation,integer_range,fraction_range)[:questions]
    # latex_questions_sheet += content + "\\end{align*}\n\\end{document}"
    # {fraction_sheet:latex_questions_sheet}

    content = self.fraction_sheet_content(questions_per_row,number_of_rows,operation,integer_range,fraction_range)

    latex_questions_sheet = HEADERS
    latex_questions_sheet += "\\section*{\\centerline{Fraction Worksheet #{title}}}\n\\vspace{#{TITLE_CONTENT_SPACE} mm}\n\\begin{align*}\n"
    latex_questions_sheet += content[:questions] + "\\end{align*}\n\\end{document}"

    latex_solutions_sheet = HEADERS
    latex_solutions_sheet += "\\section*{\\centerline{Fraction Worksheet #{title} Solutions}}\n\\vspace{#{TITLE_CONTENT_SPACE} mm}\n\\begin{align*}\n"
    latex_solutions_sheet += content[:solutions] + "\\end{align*}\n\\end{document}"

    {questions_sheet:latex_questions_sheet,solutions_sheet:latex_solutions_sheet}

  end

  private

  def self._latex_fraction(fraction)
    result = fraction.integer == 0 ? "" : "#{fraction.integer}"
    result += "\\frac{#{fraction.numerator}}{#{fraction.denominator}}"
  end

  def self._latex_sign(operation)
    sign = case operation
      when 'addition' then  '+'
      when 'subtract' then  '-'
      when 'multiply' then  '\times'
      when 'divide' then '\div'
      else '+'
    end
  end

end

# test = LatexPrinter.fraction_sheet('Test',3,6)[:fraction_sheet]
# puts test
