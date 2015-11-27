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
    context 'can generate one row of questions and answers' do
      shared_context 'random sheet with one row of questions' do
        before(:all) do
          srand(100)
          @sheet = LatexPrinter.fraction_sheet_content(3,1)
        end
      end

      include_context 'random sheet with one row of questions'

      it 'can generate one rows of fraction questions' do
        questions = @sheet[:questions]
        expected_questions = "&1.\\hspace{15pt}8\\frac{2}{5}+7\\frac{8}{9}&&2.\\"\
          "hspace{15pt}\\frac{1}{2}+5\\frac{3}{4}&&3.\\hspace{15pt}2\\frac{1}{3"\
          "}+8\\frac{2}{3}\n"
        expect(questions).to eq expected_questions
      end

      it 'can generate corresponding solutions' do
        solutions = @sheet[:solutions]
        expected_solutions = "&1.\\hspace{15pt}16\\frac{13}{45}&&2.\\hspace{15"\
          "pt}6\\frac{1}{4}&&3.\\hspace{15pt}11\\frac{0}{1}\n"
        expect(solutions).to eq expected_solutions
      end

    end

    context 'can generate six rows of questions and answers' do
      shared_context 'random sheet with six rows of questions' do
        before(:all) do
          srand(200)
          @sheet = LatexPrinter.fraction_sheet_content(2,6,['add','subtract',
            'multiply','divide'])
        end
      end

      include_context 'random sheet with six rows of questions'

      it 'can generate six rows of fraction questions' do
        questions = @sheet[:questions]
        expected_questions =  "&1.\\hspace{15pt}1\\frac{1}{2}\\times4\\frac{1}{4"\
          "}&&2.\\hspace{15pt}1\\frac{1}{2}\\div1\\frac{2}{3}\\\\[2em]\n&3.\\hsp"\
          "ace{15pt}2\\frac{1}{2}\\times1\\frac{4}{5}&&4.\\hspace{15pt}1\\frac{2"\
          "}{3}-1\\frac{1}{10}\\\\[2em]\n&5.\\hspace{15pt}10\\frac{7}{8}+3\\frac"\
          "{5}{6}&&6.\\hspace{15pt}6\\frac{1}{4}\\times3\\frac{1}{6}\\\\[2em]\n&"\
          "7.\\hspace{15pt}4\\frac{3}{4}-1\\frac{2}{3}&&8.\\hspace{15pt}\\frac{3"\
          "}{7}\\times6\\frac{4}{7}\\\\[2em]\n&9.\\hspace{15pt}4\\frac{3}{5}\\ti"\
          "mes6\\frac{2}{3}&&10.\\hspace{15pt}1\\frac{2}{7}\\div\\frac{1}{5}\\\\"\
          "[2em]\n&11.\\hspace{15pt}\\frac{2}{3}\\div5\\frac{7}{8}&&12.\\hspace{"\
          "15pt}7\\frac{2}{3}+4\\frac{1}{3}\n"
        expect(questions).to eq expected_questions
      end

      it 'can generate corresponding solutions' do
        solutions = @sheet[:solutions]
        expected_solutions = "&1.\\hspace{15pt}6\\frac{3}{8}&&2.\\hspace{15pt}"\
          "\\frac{9}{10}\\\\[2em]\n&3.\\hspace{15pt}4\\frac{1}{2}&&4.\\hspace{"\
          "15pt}\\frac{17}{30}\\\\[2em]\n&5.\\hspace{15pt}14\\frac{17}{24}&&6."\
          "\\hspace{15pt}19\\frac{19}{24}\\\\[2em]\n&7.\\hspace{15pt}3\\frac{1"\
          "}{12}&&8.\\hspace{15pt}2\\frac{40}{49}\\\\[2em]\n&9.\\hspace{15pt}3"\
          "0\\frac{2}{3}&&10.\\hspace{15pt}6\\frac{3}{7}\\\\[2em]\n&11.\\hspac"\
          "e{15pt}\\frac{16}{141}&&12.\\hspace{15pt}12\\frac{0}{1}\n"
        expect(solutions).to eq expected_solutions
      end
    end
  end

  describe '#fraction_sheet' do
    shared_context 'generate a random fraction sheet and answers' do
      before(:all) do
        srand(200)
        @sheet = LatexPrinter.fraction_sheet('Test Worksheet','Adam Smith')
      end
    end

    include_context 'generate a random fraction sheet and answers'

    it 'can generate a random latex fractions sheet' do
      expected_sheet = "\\documentclass{article}\n\\usepackage[math]{iwona}\n"\
        "\\usepackage[fleqn]{amsmath}\n\\usepackage{scrextend}\n\\changefontsi"\
        "zes[20pt]{17pt}\n\\usepackage[a4paper, left=0.7in,right=0.7in,top=1in"\
        ",bottom=1in]{geometry}\n\\pagenumbering{gobble}\n\\usepackage{fancyhd"\
        "r}\n\\renewcommand{\\headrulewidth}{0pt}\n\\pagestyle{fancy}\n\\lfoot"\
        "{FRA-HY436079Q\\quad \\textcopyright\\, Joe Zhou, 2015}\n\\rfoot{\\te"\
        "xtit{student:}\\quad Adam Smith}\n\\begin{document}\n\\section*{\\cen"\
        "terline{Fraction Test Worksheet}}\n\\vspace{10 mm}\n\\begin{align*}\n"\
        "&1.\\hspace{15pt}1\\frac{1}{2}\\times4\\frac{1}{4}&&2.\\hspace{15pt}1"\
        "\\frac{1}{2}\\div1\\frac{2}{3}\\\\[2em]\n&3.\\hspace{15pt}2\\frac{1}{"\
        "2}\\times1\\frac{4}{5}&&4.\\hspace{15pt}1\\frac{2}{3}-1\\frac{1}{10}"\
        "\\\\[2em]\n&5.\\hspace{15pt}10\\frac{7}{8}+3\\frac{5}{6}&&6.\\hspace{"\
        "15pt}6\\frac{1}{4}\\times3\\frac{1}{6}\\\\[2em]\n&7.\\hspace{15pt}4\\"\
        "frac{3}{4}-1\\frac{2}{3}&&8.\\hspace{15pt}\\frac{3}{7}\\times6\\frac{"\
        "4}{7}\\\\[2em]\n&9.\\hspace{15pt}4\\frac{3}{5}\\times6\\frac{2}{3}&&1"\
        "0.\\hspace{15pt}1\\frac{2}{7}\\div\\frac{1}{5}\n\\end{align*}\n\\end{"\
        "document}"
      expect(@sheet[:questions_sheet]).to eq expected_sheet
    end

    it 'can generate the corresponding solution sheet' do
      expected_solutions = "\\documentclass{article}\n\\usepackage[math]{iwona"\
      "}\n\\usepackage[fleqn]{amsmath}\n\\usepackage{scrextend}\n\\changefonts"\
      "izes[20pt]{17pt}\n\\usepackage[a4paper, left=0.7in,right=0.7in,top=1in,"\
      "bottom=1in]{geometry}\n\\pagenumbering{gobble}\n\\usepackage{fancyhdr}"\
      "\n\\renewcommand{\\headrulewidth}{0pt}\n\\pagestyle{fancy}\n\\lfoot{FRA"\
      "-HY436079A\\quad \\textcopyright\\, Joe Zhou, 2015}\n\\rfoot{\\textit{s"\
      "tudent:}\\quad Adam Smith}\n\\begin{document}\n\\section*{\\centerline{"\
      "Fraction Test Worksheet Solutions}}\n\\vspace{10 mm}\n\\begin{align*}\n"\
      "&1.\\hspace{15pt}6\\frac{3}{8}&&2.\\hspace{15pt}\\frac{9}{10}\\\\[2em]"\
      "\n&3.\\hspace{15pt}4\\frac{1}{2}&&4.\\hspace{15pt}\\frac{17}{30}\\\\[2e"\
      "m]\n&5.\\hspace{15pt}14\\frac{17}{24}&&6.\\hspace{15pt}19\\frac{19}{24}"\
      "\\\\[2em]\n&7.\\hspace{15pt}3\\frac{1}{12}&&8.\\hspace{15pt}2\\frac{40}"\
      "{49}\\\\[2em]\n&9.\\hspace{15pt}30\\frac{2}{3}&&10.\\hspace{15pt}6\\fra"\
      "c{3}{7}\n\\end{align*}\n\\end{document}"
      expect(@sheet[:solutions_sheet]).to eq expected_solutions
    end
  end

  describe '#one_sided_linear_equation_question_next_step' do
    it 'modify the current latex source with step 1 left addition' do
      current_latex = 'x'
      next_step = EquationStep.new(:add,5,:left)
      step_number = 1
      new_latex = LatexPrinter.one_sided_linear_equation_question_next_step(
        current_latex,next_step,step_number)
      expect(new_latex).to eq '5+x'
    end

    it 'modify the current latex source with step 2 left addition' do
      current_latex = 'some_string'
      next_step = EquationStep.new(:add,5,:left)
      step_number = 2
      new_latex = LatexPrinter.one_sided_linear_equation_question_next_step(
        current_latex,next_step,step_number)
      expect(new_latex).to eq '5+\left(some_string\right)'
    end

    it 'modify the current latex source with step of right addition' do
      current_latex = 'some_string'
      next_step = EquationStep.new(:add,5,:right)
      step_number = rand(1..10)
      new_latex = LatexPrinter.one_sided_linear_equation_question_next_step(
        current_latex,next_step,step_number)
      expect(new_latex).to eq 'some_string+5'
    end

    it 'modify the current latex source with step 1 left subtraction' do
      current_latex = 'x'
      next_step = EquationStep.new(:subtract,5,:left)
      step_number = 1
      new_latex = LatexPrinter.one_sided_linear_equation_question_next_step(
        current_latex,next_step,step_number)
      expect(new_latex).to eq '5-x'
    end

    it 'modify the current latex source with step 2 left subtraction' do
      current_latex = 'some_string'
      next_step = EquationStep.new(:subtract,5,:left)
      step_number = 2
      new_latex = LatexPrinter.one_sided_linear_equation_question_next_step(
        current_latex,next_step,step_number)
      expect(new_latex).to eq '5-\left(some_string\right)'
    end

    it 'modify the current latex source with step of right subtraction' do
      current_latex = 'some_string'
      next_step = EquationStep.new(:subtract,5,:right)
      step_number = rand(1..10)
      new_latex = LatexPrinter.one_sided_linear_equation_question_next_step(
        current_latex,next_step,step_number)
      expect(new_latex).to eq 'some_string-5'
    end

    it 'modify the current latex source with step 1 left multiplication' do
      current_latex = 'x'
      next_step = EquationStep.new(:multiply,5,:left)
      step_number = 1
      new_latex = LatexPrinter.one_sided_linear_equation_question_next_step(
        current_latex,next_step,step_number)
      expect(new_latex).to eq '5x'
    end

    it 'modify the current latex source with step 1 right multiplication' do
      current_latex = 'x'
      next_step = EquationStep.new(:multiply,5,:right)
      step_number = 1
      new_latex = LatexPrinter.one_sided_linear_equation_question_next_step(
        current_latex,next_step,step_number)
      expect(new_latex).to eq '5x'
    end

    it 'modify the current latex source with step 2 left multiplication' do
      current_latex = 'x'
      next_step = EquationStep.new(:multiply,5,:left)
      step_number = 2
      new_latex = LatexPrinter.one_sided_linear_equation_question_next_step(
        current_latex,next_step,step_number)
      expect(new_latex).to eq '5\left(x\right)'
    end

    it 'modify the current latex source with step 2 right multiplication' do
      current_latex = 'x'
      next_step = EquationStep.new(:multiply,5,:right)
      step_number = 2
      new_latex = LatexPrinter.one_sided_linear_equation_question_next_step(
        current_latex,next_step,step_number)
      expect(new_latex).to eq '5\left(x\right)'
    end

    it 'modify the current latex source with step of left division' do
      current_latex = 'some_string'
      next_step = EquationStep.new(:divide,5,:left)
      step_number = rand(1..10)
      new_latex = LatexPrinter.one_sided_linear_equation_question_next_step(
        current_latex,next_step,step_number)
      expect(new_latex).to eq '\frac{5}{some_string}'
    end

    it 'modify the current latex source with step of right division' do
      current_latex = 'some_string'
      next_step = EquationStep.new(:divide,5,:right)
      step_number = rand(1..10)
      new_latex = LatexPrinter.one_sided_linear_equation_question_next_step(
        current_latex,next_step,step_number)
      expect(new_latex).to eq '\frac{some_string}{5}'
    end
  end

  describe '#one_sided_linear_equation_question' do
    it 'creates latex for one one_sided one step question' do
      srand(100)
      question = LinearEquation.generate_one_sided(1)
      question_latex = LatexPrinter.one_sided_linear_equation_question(question,'x')
      expect(question_latex).to eq "\\frac{x}{5}=2"
    end

    it 'creates latex for one one_sided two step question' do
      srand(200)
      question = LinearEquation.generate_one_sided(2)
      question_latex = LatexPrinter.one_sided_linear_equation_question(question,'x')
      expect(question_latex).to eq "6x-11=1"
    end

    it 'creates latex for one one_sided three step question' do
      srand(300)
      question = LinearEquation.generate_one_sided(3)
      question_latex = LatexPrinter.one_sided_linear_equation_question(question,'x')
      expect(question_latex).to eq "8\\left(\\frac{47-x}{4}\\right)=88"
    end

    it 'creates latex for one one_sided four step question' do
      srand(400)
      question = LinearEquation.generate_one_sided(4)
      p question
      question_latex = LatexPrinter.one_sided_linear_equation_question(question,'x')
      expect(question_latex).to eq "43-\\left(8\\left(\\frac{x+10}{3}\\right)\\right)=3"
    end

    it 'creates latex for one one_sided five step question' do
      srand(500)
      question = LinearEquation.generate_one_sided(5)
      p question
      question_latex = LatexPrinter.one_sided_linear_equation_question(question,'x')
      expect(question_latex).to eq "4\\left(\\frac{9\\left(42-x\\right)-19}{2}\\right)=556"
    end
  end

  # describe '#one_sided_linear_equation_sheet_content' do
  #   it 'creates latex content for 3 rows fo 2 3-step-questions per row' do
  #     srand(200)
  #     questions = LinearEquation.generate_one_sided_questions(12,3)
  #     p questions
  #     questions_latex = LatexPrinter.one_sided_linear_equation_sheet_content(questions,2,6,{variable:'y'})
  #     puts questions_latex
  #     expect(questions_latex).to eq 'hello'
  #   end
  # end

end
