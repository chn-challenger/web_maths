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

  describe '#print_content' do
    it 'prints question latex for 6 rows of 2 questions per row' do
      srand(100)
      questions = generate(12)
      latex = LatexPrinter.print_content(questions)
      expect(latex).to eq "\\begin{align*}\n&1.\\hspace{15pt}14-\\frac{x}{5}=12&&2.\\hspace{15p"\
        "t}50+\\frac{24}{x}=54\\\\[2em]\n&3.\\hspace{15pt}\\frac{x+18}{4}=7&&4"\
        ".\\hspace{15pt}\\frac{48}{x}-3=3\\\\[2em]\n&5.\\hspace{15pt}\\frac{29"\
        "+x}{3}=12&&6.\\hspace{15pt}\\frac{48}{x+9}=4\\\\[2em]\n&7.\\hspace{15"\
        "pt}49-\\frac{x}{5}=48&&8.\\hspace{15pt}73-9x=46\\\\[2em]\n&9.\\hspace"\
        "{15pt}7x+10=38&&10.\\hspace{15pt}\\frac{42+x}{5}=9\\\\[2em]\n&11.\\hs"\
        "pace{15pt}\\frac{220}{46-x}=5&&12.\\hspace{15pt}3\\left(x+49\\right)="\
        "165\n\\end{align*}\n"
    end

    it 'prints question latex for 6 rows of 2 questions per row' do
      srand(200)
      questions = generate(12,LinearEquation,{steps:4,solution_range:10,variable:'y'})
      latex = LatexPrinter.print_content(questions)
      expect(latex).to eq "\\begin{align*}\n&1.\\hspace{15pt}3+\\frac{8}{6y-11}=11&&2.\\hspace{"\
        "15pt}2\\left(7\\left(y-3\\right)+24\\right)=132\\\\[2em]\n&3.\\hspace"\
        "{15pt}34-\\frac{2y+34}{4}=23&&4.\\hspace{15pt}8+\\frac{10}{41-9y}=10"\
        "\\\\[2em]\n&5.\\hspace{15pt}9\\left(88-8y\\right)+6=438&&6.\\hspace{1"\
        "5pt}3\\left(41-\\frac{32+y}{2}\\right)=72\\\\[2em]\n&7.\\hspace{15pt}"\
        "4\\left(9-\\frac{31-y}{4}\\right)=8&&8.\\hspace{15pt}3\\left(\\frac{2"\
        "40}{38-y}-3\\right)=15\\\\[2em]\n&9.\\hspace{15pt}5\\left(143-5\\left"\
        "(y+9\\right)\\right)=240&&10.\\hspace{15pt}6\\left(36-\\frac{y}{9}\\r"\
        "ight)-14=196\\\\[2em]\n&11.\\hspace{15pt}9\\left(20-\\frac{81}{y}\\ri"\
        "ght)+28=127&&12.\\hspace{15pt}4\\left(\\frac{98}{8+y}+9\\right)=64\n\\end{align*}\n"
    end

    it 'print solution latex for 2 rows of 3 questions per row' do
      srand(300)
      questions = generate(6)
      latex = LatexPrinter.print_content(questions,true,:minipage,{questions_per_row:2,number_of_rows:3})
      puts latex
      expect(latex).to eq "\\begin{minipage}[t]{0.5\\textwidth}\n\\begin{align"\
        "*}\n1.\\hspace{30pt}\\frac{47-x}{4}&=11\\\\\n47-x&=411\\\\\n47-x&=44"\
        "\\\\\n47-44&=x\\\\\n3&=x\n\\end{align*}\n\\end{minipage}\n\\begin{min"\
        "ipage}[t]{0.5\\textwidth}\n\\begin{align*}\n2.\\hspace{30pt}32+\\frac"\
        "{x}{3}&=35\\\\\n\\frac{x}{3}&=35-32\\\\\n\\frac{x}{3}&=3\\\\\nx&=33"\
        "\\\\\nx&=9\n\\end{align*}\n\\end{minipage}\n\n\\vspace{10 mm}\n\n\\be"\
        "gin{minipage}[t]{0.5\\textwidth}\n\\begin{align*}\n3.\\hspace{30pt}36"\
        "+\\frac{x}{5}&=37\\\\\n\\frac{x}{5}&=37-36\\\\\n\\frac{x}{5}&=1\\\\\n"\
        "x&=51\\\\\nx&=5\n\\end{align*}\n\\end{minipage}\n\\begin{minipage}[t]"\
        "{0.5\\textwidth}\n\\begin{align*}\n4.\\hspace{30pt}\\frac{x+43}{5}&="\
        "10\\\\\nx+43&=510\\\\\nx+43&=50\\\\\nx&=50-43\\\\\nx&=7\n\\end{align*"\
        "}\n\\end{minipage}\n\n\\vspace{10 mm}\n\n\\begin{minipage}[t]{0.5\\te"\
        "xtwidth}\n\\begin{align*}\n5.\\hspace{30pt}16-\\frac{x}{6}&=15\\\\\n1"\
        "6-15&=\\frac{x}{6}\\\\\n1&=\\frac{x}{6}\\\\\n61&=x\\\\\n6&=x\n\\end{a"\
        "lign*}\n\\end{minipage}\n\\begin{minipage}[t]{0.5\\textwidth}\n\\begi"\
        "n{align*}\n6.\\hspace{30pt}3x+29&=47\\\\\n3x&=47-29\\\\\n3x&=18\\\\\n"\
        "x&=\\frac{18}{3}\\\\\nx&=6\n\\end{align*}\n\\end{minipage}\n\n\\vspac"\
        "e{10 mm}\n\n"
    end
  end


end
