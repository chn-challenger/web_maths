require './generators/fraction'

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


p rand(2..6)
