require './generators/fraction'
require './generators/serial'
require './generators/linear_equation'
include SerialNumber

class LatexPrinter

  QUESTION_AND_NUMBER_SPACING = 15
  LINE_SPACING = 2
  TITLE_CONTENT_SPACE = 10
  TOPIC_PREFIX = 'FRA'

  HEADERS = "\\documentclass{article}\n"\
    "\\usepackage[math]{iwona}\n"\
    "\\usepackage[fleqn]{amsmath}\n"\
    "\\usepackage{scrextend}\n"\
    "\\changefontsizes[20pt]{17pt}\n"\
    "\\usepackage[a4paper, left=0.7in,right=0.7in,top=1in,bottom=1in]{geometry}\n"\
    "\\pagenumbering{gobble}\n"\
    "\\usepackage{fancyhdr}\n"\
    "\\renewcommand{\\headrulewidth}{0pt}\n"\
    "\\pagestyle{fancy}\n"



  def self.one_sided_linear_equation_question(question,unknow_variable)
    step_number = 1
    question.left_side.inject(unknow_variable) do |result, step|
      result = self.one_sided_linear_equation_question_next_step(result,step,step_number)
      step_number += 1
      result
    end + '=' + question.right_side.to_s
  end

  def self.one_sided_linear_equation_question_next_step(current_latex,step,step_number)
    modified_latex = current_latex

    if step.operation == :add && step.orientation == :left
      if step_number == 1
        modified_latex = step.value.to_s + '+' + modified_latex
      else
        modified_latex = step.value.to_s + '+\left(' + modified_latex + '\right)'
      end
    end

    if step.operation == :add && step.orientation == :right
      modified_latex = modified_latex +  '+' + step.value.to_s
    end

    if step.operation == :subtract && step.orientation == :left
      if step_number == 1
        modified_latex = step.value.to_s + '-' + modified_latex
      else
        modified_latex = step.value.to_s + '-\left(' + modified_latex + '\right)'
      end
    end

    if step.operation == :subtract && step.orientation == :right
      modified_latex = modified_latex +  '-' + step.value.to_s
    end

    if step.operation == :multiply
      if step_number == 1
        modified_latex = step.value.to_s + modified_latex
      else
        modified_latex = step.value.to_s + '\left(' + modified_latex + '\right)'
      end
    end

    if step.operation == :divide && step.orientation == :left
      modified_latex = '\frac{' + step.value.to_s + '}{' + modified_latex +  '}'
    end

    if step.operation == :divide && step.orientation == :right
      modified_latex = '\frac{' + modified_latex + '}{' + step.value.to_s +  '}'
    end

    return modified_latex
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

  def self.fraction_sheet(title='',student='',questions_per_row=2,number_of_rows=5,
    operation=['add','subtract','multiply','divide'],
    integer_range=10,fraction_range=10)

    content = self.fraction_sheet_content(questions_per_row,number_of_rows,
      operation,integer_range,fraction_range)
    serial = generate_serial

    latex_questions_sheet = HEADERS
    latex_questions_sheet += "\\lfoot{#{TOPIC_PREFIX}-#{serial}Q\\quad \\textc"\
      "opyright\\, Joe Zhou, 2015}\n\\rfoot{\\textit{student:}\\quad"\
      " #{student}}\n\\begin{document}\n"
    latex_questions_sheet += "\\section*{\\centerline{Fraction #{title}}}\n\\"\
      "vspace{#{TITLE_CONTENT_SPACE} mm}\n\\begin{align*}\n"
    latex_questions_sheet += content[:questions] + "\\end{align*}\n\\end{document}"

    latex_solutions_sheet = HEADERS
    latex_solutions_sheet += "\\lfoot{#{TOPIC_PREFIX}-#{serial}A\\quad \\textc"\
      "opyright\\, Joe Zhou, 2015}\n\\rfoot{\\textit{student:}\\quad"\
      " #{student}}\n\\begin{document}\n"
    latex_solutions_sheet += "\\section*{\\centerline{Fraction #{title} Soluti"\
      "ons}}\n\\vspace{#{TITLE_CONTENT_SPACE} mm}\n\\begin{align*}\n"
    latex_solutions_sheet += content[:solutions] + "\\end{align*}\n\\end{document}"

    {questions_sheet:latex_questions_sheet,solutions_sheet:latex_solutions_sheet}
  end

  def self.fraction_question(question)
    question_latex = self._latex_fraction(question[:fraction1]) +
      self._latex_sign(question[:operation]) + self._latex_fraction(question[:fraction2])
    solution_latex = self._latex_fraction(question[:solution])
    {question:question_latex,solution:solution_latex}
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
