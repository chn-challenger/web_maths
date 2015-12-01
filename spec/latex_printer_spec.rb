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
      expect(new_latex).to eq '5+some_string'
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
      expect(new_latex).to eq '5-some_string'
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
      expect(question_latex).to eq "54-\\frac{47-x}{4}=43"
    end

    it 'creates latex for one one_sided four step question' do
      srand(400)
      question = LinearEquation.generate_one_sided(4)
      question_latex = LatexPrinter.one_sided_linear_equation_question(question,'x')
      expect(question_latex).to eq "3\\left(38-\\frac{x+10}{3}\\right)=99"
    end

    it 'creates latex for one one_sided five step question' do
      srand(500)
      question = LinearEquation.generate_one_sided(5)
      question_latex = LatexPrinter.one_sided_linear_equation_question(question,'x')
      puts question_latex
      expect(question_latex).to eq "183-\\frac{9\\left(42-x\\right)-19}{2}=44"
    end
  end

  describe '#one_sided_linear_equation_sheet_content' do
    it 'creates latex content for 3 rows fo 2 3-step-questions per row' do
      srand(200)
      questions = LinearEquation.generate_one_sided_questions(6,3)
      questions_latex = LatexPrinter.one_sided_linear_equation_sheet_content(questions,2,3,{variable:'y'})
      expected_questions_latex = "&1.\\hspace{15pt}\\frac{8}{6y-11}=8&&2.\\hsp"\
        "ace{15pt}26-\\frac{y-5}{5}=25\\\\[2em]\n&3.\\hspace{15pt}5\\left(52-"\
        "\\frac{56}{y}\\right)=220&&4.\\hspace{15pt}7\\left(\\frac{70}{y}-6\\"\
        "right)=7\\\\[2em]\n&5.\\hspace{15pt}\\frac{10}{41-9y}=2&&6.\\hspace{"\
        "15pt}9\\left(14-\\frac{48}{y}\\right)=54\n"
      expect(questions_latex).to eq expected_questions_latex
    end

    it 'creates latex content for 6 rows fo 2 4-step-questions per row' do
      srand(300)
      questions = LinearEquation.generate_one_sided_questions(12,4)
      questions_latex = LatexPrinter.one_sided_linear_equation_sheet_content(questions,2,6)
      expected_questions_latex = "&1.\\hspace{15pt}8\\left(54-\\frac{47-x}{4}"\
        "\\right)=344&&2.\\hspace{15pt}113-7\\left(8x-22\\right)=43\\\\[2em]\n"\
        "&3.\\hspace{15pt}2\\left(2\\left(5+x\\right)-14\\right)=28&&4.\\hspac"\
        "e{15pt}3\\left(\\frac{9}{x-2}-4\\right)=15\\\\[2em]\n&5.\\hspace{15pt"\
        "}3\\left(25-\\frac{x}{2}\\right)-32=37&&6.\\hspace{15pt}\\frac{2x-10}"\
        "{2}+44=45\\\\[2em]\n&7.\\hspace{15pt}6\\left(24-\\frac{18}{x}\\right)"\
        "+43=151&&8.\\hspace{15pt}6\\left(2\\left(49-x\\right)+48\\right)=816"\
        "\\\\[2em]\n&9.\\hspace{15pt}5\\left(\\frac{136}{11+x}-6\\right)=10&&1"\
        "0.\\hspace{15pt}6\\left(17-\\frac{20}{x}\\right)+46=124\\\\[2em]\n&11"\
        ".\\hspace{15pt}6\\left(77-7\\left(7-x\\right)\\right)=252&&12.\\hspac"\
        "e{15pt}38-3\\left(7-\\frac{x}{2}\\right)=20\n"
      expect(questions_latex).to eq expected_questions_latex
    end
  end

  describe '#one_sided_linear_equation_sheet' do
    it 'creates a worksheet of 10 questions' do
      #feature test
      # srand(111111)
      # questions2 = LinearEquation.generate_one_sided_questions(4,2)
      # sheet_latex2 = LatexPrinter.one_sided_linear_equation_sheet_content(questions2,2,2)
      # puts sheet_latex2
      # sheet_solution2 = LatexPrinter.one_sided_linear_equation_sheet_solutions(questions2,2,2)
      # p sheet_solution2
      srand(2314)
      questions = LinearEquation.generate_one_sided_questions(10,3)
      sheet_latex = LatexPrinter.one_sided_linear_equation_sheet('Worksheet 1',
        'Billy Thomas',questions)[:questions_sheet]
      expected_sheet_latex = "\\documentclass{article}\n\\usepackage[math]{iwo"\
        "na}\n\\usepackage[fleqn]{amsmath}\n\\usepackage{scrextend}\n\\changef"\
        "ontsizes[20pt]{17pt}\n\\usepackage[a4paper, left=0.7in,right=0.7in,to"\
        "p=1in,bottom=1in]{geometry}\n\\pagenumbering{gobble}\n\\usepackage{fa"\
        "ncyhdr}\n\\renewcommand{\\headrulewidth}{0pt}\n\\pagestyle{fancy}\n\\"\
        "lfoot{LEN-WQ571259Q\\quad \\textcopyright\\, Joe Zhou, 2015}\n\\rfoot"\
        "{\\textit{student:}\\quad Billy Thomas}\n\\begin{document}\n\\section"\
        "*{\\centerline{Linear Equations Worksheet 1}}\n\\vspace{10 mm}\n\\beg"\
        "in{align*}\n&1.\\hspace{15pt}6\\left(44+\\frac{x}{3}\\right)=270&&2."\
        "\\hspace{15pt}\\frac{42+4x}{2}=37\\\\[2em]\n&3.\\hspace{15pt}\\frac{1"\
        "9-x}{2}-3=3&&4.\\hspace{15pt}\\frac{x+26}{2}+30=45\\\\[2em]\n&5.\\hsp"\
        "ace{15pt}5\\left(36+\\frac{x}{7}\\right)=185&&6.\\hspace{15pt}\\frac{"\
        "2}{x-4}+28=30\\\\[2em]\n&7.\\hspace{15pt}9\\left(\\frac{x}{6}+31\\rig"\
        "ht)=288&&8.\\hspace{15pt}4\\left(5x+30\\right)=180\\\\[2em]\n&9.\\hsp"\
        "ace{15pt}34-2\\left(x-3\\right)=26&&10.\\hspace{15pt}33+\\frac{164}{4"\
        "9-x}=37\n\\end{align*}\n\\end{document}"
      expect(sheet_latex).to eq expected_sheet_latex
    end
  end

  describe '#equation_next_step' do
    it 'modifies latex output for left addition' do
      current_latex = 'x'
      next_step = EquationStep.new(:add,5,:left)
      step_number = 1
      new_latex = LatexPrinter.equation_next_step(
        current_latex,next_step,step_number)
      expect(new_latex).to eq '5+x'
    end

    #more tests?
  end

  describe '#single_general_equation' do
    it 'generates latex for one general equation' do
      equation = Equation.new(Expression.new('x',[EquationStep.new(:add,5,:right)]),Expression.new(8))
      question_latex = LatexPrinter.single_general_equation(equation)
      expect(question_latex).to eq 'x+5=8'
    end

    it 'generates latex for a two step general equation' do
      equation = Equation.new(Expression.new('x',[EquationStep.new(:add,5,:right),
        EquationStep.new(:multiply,5,:left)]),Expression.new(8))
      question_latex = LatexPrinter.single_general_equation(equation)
      expect(question_latex).to eq "5\\left(x+5\\right)=8"
    end

    it 'generates latex for a three step general equation' do
      equation = Equation.new(Expression.new('x',[EquationStep.new(:add,5,:right),
        EquationStep.new(:multiply,5,:left),EquationStep.new(:divide,125,:left)]),
        Expression.new(8))
      question_latex = LatexPrinter.single_general_equation(equation)
      expect(question_latex).to eq "\\frac{125}{5\\left(x+5\\right)}=8"
    end

    it 'generates latex for a two step two sided general equation' do
      equation = Equation.new(Expression.new('x',[EquationStep.new(:add,5,:right),
        EquationStep.new(:multiply,5,:left)]),Expression.new('y',
        [EquationStep.new(:subtract,5,:right),EquationStep.new(:divide,5,:left)]))
      question_latex = LatexPrinter.single_general_equation(equation)
      expect(question_latex).to eq "5\\left(x+5\\right)=\\frac{5}{y-5}"
    end
  end

end
