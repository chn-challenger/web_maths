require './generators/latex_printer'

sheet = LatexPrinter.fraction_sheet('Worksheet 1','Jack Lu',2,8,['add','subtract','multiply','divide'],4)
# puts sheet[:questions_sheet]
filename1 = 'test_sheet.tex'
File.open filename1, 'w' do |f|
  f.write sheet[:questions_sheet]
end

filename2 = 'test_answers.tex'
File.open filename2, 'w' do |f|
  f.write sheet[:solutions_sheet]
end
