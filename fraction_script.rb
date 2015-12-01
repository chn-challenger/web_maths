require 'fileutils'
require './generators/latex_printer'

sheet_title = 'Worksheet 2'
student = 'Test'

questions_per_row = 2
number_of_rows = 7
# types = ['multiply','divide']
types = ['subtract','add','multiply','divide']
integer_difficulty_range = 6
fraction_difficulty_range = 10
keep_tex_source = true


#generate sheet and setup filenames
file_prefix = 'fraction-'
date = Time.new.year.to_s + '-' + Time.new.month.to_s + '-' + Time.new.day.to_s
#generate sheet
sheet = LatexPrinter.fraction_sheet(sheet_title,student,questions_per_row,number_of_rows,types,integer_difficulty_range)
directory_name = file_prefix + sheet_title.downcase.gsub(" ",'') + '-'+ student.downcase.gsub(" ",'')+'-' + date
questions_sheet_name = directory_name + '-' + 'q.tex'
answers_sheet_name = directory_name +  '-' + 'a.tex'
#make temp directory and output directory which is the prefix of the sheet
FileUtils.mkdir_p('./output/temp')
FileUtils.mkdir_p('./output/'+directory_name)
#make the question sheet source tex
questions_file_path = 'output/temp/' + questions_sheet_name
File.open questions_file_path, 'w' do |f|
  f.write sheet[:questions_sheet]
end
#make the answer sheet source tex
answers_file_path = 'output/temp/' + answers_sheet_name
File.open answers_file_path, 'w' do |f|
  f.write sheet[:solutions_sheet]
end
#set pdflatex command strings
questions_to_pdf = 'pdflatex -output-directory=./output/temp ' + questions_file_path
answers_to_pdf = 'pdflatex -output-directory=./output/temp ' + answers_file_path
#compile the pdfs from the latex source files
system(questions_to_pdf)
system(answers_to_pdf)
#set paths for moving pdf files
pdf_questions_path = './output/temp/' + directory_name + '-q.pdf'
pdf_answers_path = './output/temp/' + directory_name + '-a.pdf'
new_directory = './output/' + directory_name
#move pdf files to output directory to be saved
FileUtils.mv(pdf_questions_path, new_directory)
FileUtils.mv(pdf_answers_path, new_directory)
#move source tex files as well if flag is set to true
if keep_tex_source == true
  FileUtils.mv('./output/temp/'+questions_sheet_name, new_directory)
  FileUtils.mv('./output/temp/'+answers_sheet_name, new_directory)
end
#delete temp folder and its contents
FileUtils.rm_rf('./output/temp')
