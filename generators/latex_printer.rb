require './generators/fraction'

class LatexPrinter
# include Questions

  # HEADERS = '\documentclass{article}
  #           \usepackage[math]{iwona}
  #           \usepackage[fleqn]{amsmath}
  #           \usepackage{scrextend}
  #           \changefontsizes[20pt]{18pt}
  #           \usepackage[margin=0.7in]{geometry}
  #           \pagenumbering{gobble}
  #           \usepackage{setspace}
  #           \renewcommand{\baselinestretch}{1.5}
  #           \begin{document}'
  #
  # TEST_QUESTIONS = '1.\hspace{10pt}&2\frac{3}{4} + 4 \frac{2}{7} \hspace{90pt} &12.\hspace{10pt} &4\frac{2}{5} + 3\frac{5}{9}\\\[2em]
  # 3.\hspace{10pt}&2\frac{3}{4}  + 2314 \frac{12}{17} &11.\hspace{10pt}&4\frac{2}{5} + 3\frac{5}{9}\\\[2em]
  # 1.\hspace{10pt}&2\frac{3}{4} + 4 \frac{2}{7} \hspace{90pt} &12.\hspace{10pt} &4\frac{2}{5} + 3\frac{5}{9}\\\[2em]
  # 3.\hspace{10pt}&2\frac{3}{4}  + 2314 \frac{12}{17} &11.\hspace{10pt}&4\frac{2}{5} + 3\frac{5}{9}\\\[2em]
  # 1.\hspace{10pt}&2\frac{3}{4} + 4 \frac{2}{7} \hspace{90pt} &12.\hspace{10pt} &4\frac{2}{5} + 3\frac{5}{9}\\\[2em]
  # 3.\hspace{10pt}&2\frac{3}{4}  + 2314 \frac{12}{17} &11.\hspace{10pt}&4\frac{2}{5} + 3\frac{5}{9}\\\[2em]
  # 3.\hspace{10pt}&2\frac{3}{4}  + 4 \frac{2}{7}  &11.&4\frac{2}{5} + 3\frac{5}{9}'
  #
  # def latex_worksheet(title='Worksheet 1',questions_per_row=2,number_of_rows=5,question_type=['addition'])
  #   result = HEADERS + "\n" + '\section*{\centerline{Fraction ' + title + '}}'+ "\n\n" + '\vspace{10 mm}' + "\n" + '\begin{align*}' + "\n"
  #   result += TEST_QUESTIONS + "\n" + '\end{align*}' + "\n" + '\end{document}'+ "\n"
  #   result
  # end

  def self.fraction_question(operation='add',integer_range=10,fraction_range=10)
    question = Fraction.question(operation,integer_range,fraction_range)
    question_latex = self._latex_fraction(question[:fraction1]) +
      self._latex_sign(operation) + self._latex_fraction(question[:fraction2])
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

#
# def test_print()
#   '\documentclass{article}
# \usepackage[math]{iwona}
# \usepackage[fleqn]{amsmath}
# \usepackage{scrextend}
# \changefontsizes[20pt]{18pt}
# \usepackage[margin=0.7in]{geometry}
# \pagenumbering{gobble}
# \usepackage{setspace}
# \renewcommand{\baselinestretch}{1.5}
# \begin{document}
#
# \section*{\centerline{Fraction Worksheet 2}}
#
# \vspace{10 mm}
#
#
# \begin{align*}
# 1.\hspace{10pt}&2\frac{3}{4} + 4 \frac{2}{7} \hspace{90pt} &12.\hspace{10pt} &4\frac{2}{5} + 3\frac{5}{9}\\\[2em]
# 3.\hspace{10pt}&2\frac{3}{4}  + 2314 \frac{12}{17} &11.\hspace{10pt}&4\frac{2}{5} + 3\frac{5}{9}\\\[2em]
# 1.\hspace{10pt}&2\frac{3}{4} + 4 \frac{2}{7} \hspace{90pt} &12.\hspace{10pt} &4\frac{2}{5} + 3\frac{5}{9}\\\[2em]
# 3.\hspace{10pt}&2\frac{3}{4}  + 2314 \frac{12}{17} &11.\hspace{10pt}&4\frac{2}{5} + 3\frac{5}{9}\\\[2em]
# 1.\hspace{10pt}&2\frac{3}{4} + 4 \frac{2}{7} \hspace{90pt} &12.\hspace{10pt} &4\frac{2}{5} + 3\frac{5}{9}\\\[2em]
# 3.\hspace{10pt}&2\frac{3}{4}  + 2314 \frac{12}{17} &11.\hspace{10pt}&4\frac{2}{5} + 3\frac{5}{9}\\\[2em]
# 3.\hspace{10pt}&2\frac{3}{4}  + 4 \frac{2}{7}  &11.&4\frac{2}{5} + 3\frac{5}{9}
# \end{align*}
#
# \end{document}
# '
# end
#
# # puts test_print
# filename = 'testfile3.tex'
# printer = LatexPrinter.new.latex_worksheet
# file_content = printer
#
# File.open filename, 'w' do |f|
#   f.write file_content
# end

a = 5
b = 6
# puts "\\frac{#{a}}{#{b}}"
# c = LatexPrinter.new
d = LatexPrinter.fraction_question
# puts d
# puts d
