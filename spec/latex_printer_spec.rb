require './generators/latex_printer'

describe LatexPrinter do
  describe '#fraction_question' do
    it 'can print latex fraction addition question' do
      srand(100)
      question = Fraction.question('add')
      latex_result = LatexPrinter.fraction_question(question)
      expected_result_hash = {question:"8\\frac{2}{5}+7\\frac{8}{9}",
                              solution:"16\\frac{13}{45}"}
      expect(latex_result).to eq expected_result_hash
    end

    it 'can print latex fraction subtraction question' do
      srand(200)
      question = Fraction.question('subtract')
      latex_result = LatexPrinter.fraction_question(question)
      expected_result_hash = {question:"10\\frac{1}{2}-4\\frac{5}{9}",solution:"5\\frac{17}{18}"}
      expect(latex_result).to eq expected_result_hash
    end

    it 'can print latex fraction multiplication question' do
      srand(300)
      question = Fraction.question('multiply')
      latex_result = LatexPrinter.fraction_question(question)
      expected_result_hash = {question:"1\\frac{2}{3}\\times2\\frac{1}{2}", solution:"4\\frac{1}{6}"}
      expect(latex_result).to eq expected_result_hash
    end

    it 'can print latex fraction division question' do
      srand(400)
      question = Fraction.question('divide')
      latex_result = LatexPrinter.fraction_question(question)
      expected_result_hash = {question:"4\\frac{1}{4}\\div4\\frac{4}{5}", solution:"\\frac{85}{96}"}
      expect(latex_result).to eq expected_result_hash
    end
  end

  describe '#fraction_questionsheet_content' do
    it 'can generate one rows of fraction questions' do
      srand(100)
      questions = LatexPrinter.fraction_sheet_content(3,1)[:questions]
      expected_questions =  "1.\\hspace{15pt}&8\\frac{2}{5}+7\\frac{8}{9}&2.\\"\
        "hspace{15pt}&\\frac{1}{2}+5\\frac{3}{4}&3.\\hspace{15pt}&2\\frac{1}{3"\
        "}+8\\frac{2}{3}\n"
      expect(questions).to eq expected_questions
    end
    it 'can generate six rows of fraction questions' do
      srand(200)
      questions = LatexPrinter.fraction_sheet_content(2,6,['add','subtract',
        'multiply','divide'])[:questions]
      expected_questions =  "1.\\hspace{15pt}&1\\frac{1}{2}\\times4\\frac{1}{4"\
        "}&2.\\hspace{15pt}&1\\frac{1}{2}\\div1\\frac{2}{3}\\\\[2em]\n3.\\hspa"\
        "ce{15pt}&2\\frac{1}{2}\\times1\\frac{4}{5}&4.\\hspace{15pt}&1\\frac{2"\
        "}{3}-1\\frac{1}{10}\\\\[2em]\n5.\\hspace{15pt}&10\\frac{7}{8}+3\\frac"\
        "{5}{6}&6.\\hspace{15pt}&6\\frac{1}{4}\\times3\\frac{1}{6}\\\\[2em]\n7"\
        ".\\hspace{15pt}&4\\frac{3}{4}-1\\frac{2}{3}&8.\\hspace{15pt}&\\frac{3"\
        "}{7}\\times6\\frac{4}{7}\\\\[2em]\n9.\\hspace{15pt}&4\\frac{3}{5}\\ti"\
        "mes6\\frac{2}{3}&10.\\hspace{15pt}&1\\frac{2}{7}\\div\\frac{1}{5}\\\\"\
        "[2em]\n11.\\hspace{15pt}&\\frac{2}{3}\\div5\\frac{7}{8}&12.\\hspace{1"\
        "5pt}&7\\frac{2}{3}+4\\frac{1}{3}\n"
      expect(questions).to eq expected_questions
    end
  end
end
