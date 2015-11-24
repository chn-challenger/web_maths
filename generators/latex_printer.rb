require './generators/question'

class LatexPrinter
include Questions

  HEADERS = '\documentclass{article}
            \usepackage[math]{iwona}
            \usepackage[fleqn]{amsmath}
            \usepackage{scrextend}
            \changefontsizes[20pt]{18pt}
            \usepackage[margin=0.7in]{geometry}
            \pagenumbering{gobble}
            \usepackage{setspace}
            \renewcommand{\baselinestretch}{1.5}
            \begin{document}'

  TEST_QUESTIONS = '1.\hspace{10pt}&2\frac{3}{4} + 4 \frac{2}{7} \hspace{90pt} &12.\hspace{10pt} &4\frac{2}{5} + 3\frac{5}{9}\\\[2em]
  3.\hspace{10pt}&2\frac{3}{4}  + 2314 \frac{12}{17} &11.\hspace{10pt}&4\frac{2}{5} + 3\frac{5}{9}\\\[2em]
  1.\hspace{10pt}&2\frac{3}{4} + 4 \frac{2}{7} \hspace{90pt} &12.\hspace{10pt} &4\frac{2}{5} + 3\frac{5}{9}\\\[2em]
  3.\hspace{10pt}&2\frac{3}{4}  + 2314 \frac{12}{17} &11.\hspace{10pt}&4\frac{2}{5} + 3\frac{5}{9}\\\[2em]
  1.\hspace{10pt}&2\frac{3}{4} + 4 \frac{2}{7} \hspace{90pt} &12.\hspace{10pt} &4\frac{2}{5} + 3\frac{5}{9}\\\[2em]
  3.\hspace{10pt}&2\frac{3}{4}  + 2314 \frac{12}{17} &11.\hspace{10pt}&4\frac{2}{5} + 3\frac{5}{9}\\\[2em]
  3.\hspace{10pt}&2\frac{3}{4}  + 4 \frac{2}{7}  &11.&4\frac{2}{5} + 3\frac{5}{9}'

  def latex_worksheet(title='Worksheet 1',questions_per_row=2,number_of_rows=5,question_type=['addition'])
    result = HEADERS + "\n" + '\section*{\centerline{Fraction ' + title + '}}'+ "\n\n" + '\vspace{10 mm}' + "\n" + '\begin{align*}' + "\n"
    result += TEST_QUESTIONS + "\n" + '\end{align*}' + "\n" + '\end{document}'+ "\n"
    result
  end

  def latex_fraction_question(operation='multiply',integer_range=10,fraction_range=10)
    question = fraction_question(operation,integer_range,fraction_range)
    latex_result = {}
    # latex_result[:question] = "#{question[:fraction1].integer}\\frac{#{question[:fraction1].numerator}}{#{question[:fraction1].denominator}}"
    latex_result[:question] = _latex_fraction(question[:fraction1])
    case operation
      when 'addition' then sign = '+'
      when 'subtract' then sign = '-'
      when 'multiply' then sign = '\times'
      when 'divide' then sign = '\div'
    end
    latex_result[:question] += sign
    # latex_result[:question] += "#{question[:fraction2].integer}\\frac{#{question[:fraction2].numerator}}{#{question[:fraction2].denominator}}"
    # latex_result[:solution] = "#{question[:solution].integer}\\frac{#{question[:solution].numerator}}{#{question[:solution].denominator}}"
    latex_result[:question] += _latex_fraction(question[:fraction2])
    latex_result[:solution] = _latex_fraction(question[:solution])

    puts latex_result[:question]
    puts latex_result[:solution]

    puts ''
    puts ''

    return latex_result
  end

  private

  def _latex_fraction(fraction)
    # if fraction.integer == 0
    #   "\\frac{#{fraction.numerator}}{#{fraction.denominator}}"
    # else
    #   "#{fraction.integer}\\frac{#{fraction.numerator}}{#{fraction.denominator}}"
    # end
    result = fraction.integer == 0 ? "" : "#{fraction.integer}"
    result += "\\frac{#{fraction.numerator}}{#{fraction.denominator}}"
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
c = LatexPrinter.new
d = c.latex_fraction_question
puts d
