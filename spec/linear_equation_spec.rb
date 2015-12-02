require './generators/linear_equation'

describe LinearEquation do
  describe '#generate' do
    context 'one one-step question' do
      it 'one 1 left addition step question' do
        srand(143)
        questions = LinearEquation.generate
        left_side = Expression.new('x',[EquationStep.new(:add,49,:left)])
        right_side= Expression.new(52)
        solution = {"x"=>3}
        expected_question = LinearEquation.new(left_side,right_side,solution)
        expect(questions).to eq expected_question
      end

      it 'one 1 right addition step question' do
        srand(110)
        questions = LinearEquation.generate
        left_side = Expression.new('x',[EquationStep.new(:add,27,:right)])
        right_side= Expression.new(29)
        solution = {"x"=>2}
        expected_question = LinearEquation.new(left_side,right_side,solution)
        expect(questions).to eq expected_question
      end

      it 'one 1 left subtraction step question' do
        srand(137)
        questions = LinearEquation.generate
        left_side = Expression.new('x',[EquationStep.new(:subtract,21,:left)])
        right_side= Expression.new(13)
        solution = {"x"=>8}
        expected_question = LinearEquation.new(left_side,right_side,solution)
        expect(questions).to eq expected_question
      end

      it 'one 1 right subtraction step question' do
        srand(141)
        questions = LinearEquation.generate
        left_side = Expression.new('x',[EquationStep.new(:subtract,5,:right)])
        right_side= Expression.new(3)
        solution = {"x"=>8}
        expected_question = LinearEquation.new(left_side,right_side,solution)
        expect(questions).to eq expected_question
      end

      it 'one 1 multiplication step question' do
        srand(123)
        questions = LinearEquation.generate
        left_side = Expression.new('x',[EquationStep.new(:multiply,3,:left)])
        right_side= Expression.new(12)
        solution = {"x"=>4}
        expected_question = LinearEquation.new(left_side,right_side,solution)
        expect(questions).to eq expected_question
      end

      it 'one 1 left division step question' do
        srand(115)
        questions = LinearEquation.generate
        left_side = Expression.new('x',[EquationStep.new(:divide,32,:left)])
        right_side= Expression.new(8)
        solution = {"x"=>4}
        expected_question = LinearEquation.new(left_side,right_side,solution)
        expect(questions).to eq expected_question
      end

      it 'one 1 right division step question' do
        srand(100)
        questions = LinearEquation.generate
        left_side = Expression.new('x',[EquationStep.new(:divide,5,:right)])
        right_side= Expression.new(2)
        solution = {"x"=>10}
        expected_question = LinearEquation.new(left_side,right_side,solution)
        expect(questions).to eq expected_question
      end
    end

    context 'one two-step question' do
      it 'multiply then right subtract question' do
        srand(200)
        questions = LinearEquation.generate({steps:2,solution_range:10,variable:'x'})
        step1 = EquationStep.new(:multiply,6,:left)
        step2 = EquationStep.new(:subtract,11,:right)
        left_side = Expression.new('x',[step1,step2])
        right_side= Expression.new(1)
        solution = {"x"=>2}
        expected_question = LinearEquation.new(left_side,right_side,solution)
        expect(questions).to eq expected_question
      end

      it 'left subtract then right divide question' do
        srand(300)
        questions = LinearEquation.generate({steps:2,solution_range:10,variable:'x'})
        step1 = EquationStep.new(:subtract,47,:left)
        step2 = EquationStep.new(:divide,4,:right)
        left_side = Expression.new('x',[step1,step2])
        right_side= Expression.new(11)
        solution = {"x"=>3}
        expected_question = LinearEquation.new(left_side,right_side,solution)
        expect(questions).to eq expected_question
      end

      it 'right add then right divide question' do
        srand(400)
        questions = LinearEquation.generate({steps:2,solution_range:10,variable:'x'})
        step1 = EquationStep.new(:add,10,:right)
        step2 = EquationStep.new(:divide,3,:right)
        left_side = Expression.new('x',[step1,step2])
        right_side= Expression.new(5)
        solution = {"x"=>5}
        expected_question = LinearEquation.new(left_side,right_side,solution)
        expect(questions).to eq expected_question
      end

      it 'left subtract then left multiply question' do
        srand(500)
        questions = LinearEquation.generate({steps:2,solution_range:10,variable:'x'})
        step1 = EquationStep.new(:subtract,42,:left)
        step2 = EquationStep.new(:multiply,9,:left)
        left_side = Expression.new('x',[step1,step2])
        right_side= Expression.new(297)
        solution = {"x"=>9}
        expected_question = LinearEquation.new(left_side,right_side,solution)
        expect(questions).to eq expected_question
      end

      it 'left subtract then left multiply question' do
        srand(600)
        questions = LinearEquation.generate({steps:2,solution_range:10,variable:'x'})
        step1 = EquationStep.new(:subtract,4,:right)
        step2 = EquationStep.new(:divide,2,:right)
        left_side = Expression.new('x',[step1,step2])
        right_side= Expression.new(1)
        solution = {"x"=>6}
        expected_question = LinearEquation.new(left_side,right_side,solution)
        expect(questions).to eq expected_question
      end
    end

    context 'one three-step question' do
      it 'right divide left subtract left multiply question' do
        srand(100)
        questions = LinearEquation.generate({steps:3,solution_range:10,variable:'x'})
        step1 = EquationStep.new(:divide,5,:right)
        step2 = EquationStep.new(:subtract,14,:left)
        step3 = EquationStep.new(:multiply,6,:left)
        left_side = Expression.new('x',[step1,step2,step3])
        right_side= Expression.new(72)
        solution = {"x"=>10}
        expected_question = LinearEquation.new(left_side,right_side,solution)
        expect(questions).to eq expected_question
      end

      it 'left multiply right subtract left divide question' do
        srand(200)
        questions = LinearEquation.generate({steps:3,solution_range:10,variable:'x'})
        step1 = EquationStep.new(:multiply,6,:left)
        step2 = EquationStep.new(:subtract,11,:right)
        step3 = EquationStep.new(:divide,8,:left)
        left_side = Expression.new('x',[step1,step2,step3])
        right_side= Expression.new(8)
        solution = {"x"=>2}
        expected_question = LinearEquation.new(left_side,right_side,solution)
        expect(questions).to eq expected_question
      end

      it 'left subtract right divide left subtract question' do
        srand(300)
        questions = LinearEquation.generate({steps:3,solution_range:10,variable:'x'})
        step1 = EquationStep.new(:subtract,47,:left)
        step2 = EquationStep.new(:divide,4,:right)
        step3 = EquationStep.new(:subtract,54,:left)
        left_side = Expression.new('x',[step1,step2,step3])
        right_side= Expression.new(43)
        solution = {"x"=>3}
        expected_question = LinearEquation.new(left_side,right_side,solution)
        expect(questions).to eq expected_question
      end
    end

    context 'one four-step question' do
      it 'right divide left subtract left multiply right add question' do
        srand(100)
        questions = LinearEquation.generate({steps:4,solution_range:10,variable:'x'})
        step1 = EquationStep.new(:divide,5,:right)
        step2 = EquationStep.new(:subtract,14,:left)
        step3 = EquationStep.new(:multiply,6,:left)
        step4 = EquationStep.new(:add,4,:right)
        left_side = Expression.new('x',[step1,step2,step3,step4])
        right_side= Expression.new(76)
        solution = {"x"=>10}
        expected_question = LinearEquation.new(left_side,right_side,solution)
        expect(questions).to eq expected_question
      end

      it 'left multiply right subtract left divide left add question' do
        srand(200)
        questions = LinearEquation.generate({steps:4,solution_range:10,variable:'x'})
        step1 = EquationStep.new(:multiply,6,:left)
        step2 = EquationStep.new(:subtract,11,:right)
        step3 = EquationStep.new(:divide,8,:left)
        step4 = EquationStep.new(:add,3,:left)
        left_side = Expression.new('x',[step1,step2,step3,step4])
        right_side= Expression.new(11)
        solution = {"x"=>2}
        expected_question = LinearEquation.new(left_side,right_side,solution)
        expect(questions).to eq expected_question
      end
    end

    context 'one five-step question' do
      it 'right divide left subtract left multiply right add left multiply question' do
        srand(100)
        questions = LinearEquation.generate({steps:5,solution_range:10,variable:'x'})
        step1 = EquationStep.new(:divide,5,:right)
        step2 = EquationStep.new(:subtract,14,:left)
        step3 = EquationStep.new(:multiply,6,:left)
        step4 = EquationStep.new(:add,4,:right)
        step5 = EquationStep.new(:multiply,8,:left)
        left_side = Expression.new('x',[step1,step2,step3,step4,step5])
        right_side= Expression.new(608)
        solution = {"x"=>10}
        expected_question = LinearEquation.new(left_side,right_side,solution)
        expect(questions).to eq expected_question
      end
    end
  end

  describe '#_solution_next_step' do
    it 'returns 1st step of a one step right addition equation' do
      equation = LinearEquation.new(Expression.new('x',
        [EquationStep.new(:add,5,:right)]),Expression.new(11))
      arranged_equation = LinearEquation.new(Expression.new('x'),
        Expression.new(11,[EquationStep.new(:subtract,5,:right)]))
      expect(equation._solution_next_step).to eq arranged_equation
    end

    it 'returns 2nd step of a one step right addition equation' do
      equation = LinearEquation.new(Expression.new('x'),
        Expression.new(11,[EquationStep.new(:subtract,5,:right)]))
      arranged_equation = LinearEquation.new(Expression.new('x'),
        Expression.new(6))
      expect(equation._solution_next_step).to eq arranged_equation
    end

    it 'returns 1st step of a one step left addition equation' do
      equation = LinearEquation.new(Expression.new('x',
        [EquationStep.new(:add,5,:left)]),Expression.new(11))
      arranged_equation = LinearEquation.new(Expression.new('x'),
        Expression.new(11,[EquationStep.new(:subtract,5,:right)]))
      expect(equation._solution_next_step).to eq arranged_equation
    end

    it 'returns 2nd step of a one step left addition equation' do
      equation = LinearEquation.new(Expression.new('x'),
        Expression.new(11,[EquationStep.new(:subtract,5,:right)]))
      arranged_equation = LinearEquation.new(Expression.new('x'),
        Expression.new(6))
      expect(equation._solution_next_step).to eq arranged_equation
    end

    it 'returns 1st step of a one step right multiplication equation' do
      equation = LinearEquation.new(Expression.new('x',
        [EquationStep.new(:multiply,5,:right)]),Expression.new(15))
      arranged_equation = LinearEquation.new(Expression.new('x'),
        Expression.new(15,[EquationStep.new(:divide,5,:right)]))
      expect(equation._solution_next_step).to eq arranged_equation
    end

    it 'returns 2nd step of a one step right multiplication equation' do
      equation = LinearEquation.new(Expression.new('x'),
        Expression.new(15,[EquationStep.new(:divide,5,:right)]))
      arranged_equation = LinearEquation.new(Expression.new('x'),
        Expression.new(3))
      expect(equation._solution_next_step).to eq arranged_equation
    end

    it 'returns 1st step of a one step left multiplication equation' do
      equation = LinearEquation.new(Expression.new('x',
        [EquationStep.new(:multiply,5,:left)]),Expression.new(15))
      arranged_equation = LinearEquation.new(Expression.new('x'),
        Expression.new(15,[EquationStep.new(:divide,5,:right)]))
      expect(equation._solution_next_step).to eq arranged_equation
    end

    it 'returns 2nd step of a one step left multiplication equation' do
      equation = LinearEquation.new(Expression.new('x'),
        Expression.new(15,[EquationStep.new(:divide,5,:right)]))
      arranged_equation = LinearEquation.new(Expression.new('x'),
        Expression.new(3))
      expect(equation._solution_next_step).to eq arranged_equation
    end

    it 'returns 1st step of a one step right subtraction equation' do
      equation = LinearEquation.new(Expression.new('x',
        [EquationStep.new(:subtract,5,:right)]),Expression.new(15))
      arranged_equation = LinearEquation.new(Expression.new('x'),
        Expression.new(15,[EquationStep.new(:add,5,:right)]))
      expect(equation._solution_next_step).to eq arranged_equation
    end

    it 'returns 2nd step of a one step right subtraction equation' do
      equation = LinearEquation.new(Expression.new('x'),
        Expression.new(15,[EquationStep.new(:add,5,:right)]))
      arranged_equation = LinearEquation.new(Expression.new('x'),
        Expression.new(20))
      expect(equation._solution_next_step).to eq arranged_equation
    end

    it 'returns 1st step of a one step right division equation' do
      equation = LinearEquation.new(Expression.new('x',
        [EquationStep.new(:divide,5,:right)]),Expression.new(15))
      arranged_equation = LinearEquation.new(Expression.new('x'),
        Expression.new(15,[EquationStep.new(:multiply,5,:right)]))
      expect(equation._solution_next_step).to eq arranged_equation
    end

    it 'returns 2nd step of a one step right division equation' do
      equation = LinearEquation.new(Expression.new('x'),
        Expression.new(15,[EquationStep.new(:multiply,5,:right)]))
      arranged_equation = LinearEquation.new(Expression.new('x'),
        Expression.new(75))
      expect(equation._solution_next_step).to eq arranged_equation
    end

    it 'returns 1st step of a one step left subtraction equation' do
      equation = LinearEquation.new(Expression.new('x',
        [EquationStep.new(:subtract,15,:left)]),Expression.new(5))
      arranged_equation = LinearEquation.new(Expression.new(5,
        [EquationStep.new(:subtract,15,:left)]),Expression.new('x'))
      expect(equation._solution_next_step).to eq arranged_equation
    end

    it 'returns 2st step of a one step left subtraction equation' do
      equation = LinearEquation.new(Expression.new(5,
        [EquationStep.new(:subtract,15,:left)]),Expression.new('x'))
      arranged_equation = LinearEquation.new(Expression.new(10),Expression.new('x'))
      expect(equation._solution_next_step).to eq arranged_equation
    end

    it 'returns 1st step of a one step left division equation' do
      equation = LinearEquation.new(Expression.new('x',
        [EquationStep.new(:divide,15,:left)]),Expression.new(5))
      arranged_equation = LinearEquation.new(Expression.new(5,
        [EquationStep.new(:divide,15,:left)]),Expression.new('x'))
      expect(equation._solution_next_step).to eq arranged_equation
    end

    it 'returns 2st step of a one step left division equation' do
      equation = LinearEquation.new(Expression.new(5,
        [EquationStep.new(:divide,15,:left)]),Expression.new('x'))
      arranged_equation = LinearEquation.new(Expression.new(3),Expression.new('x'))
      expect(equation._solution_next_step).to eq arranged_equation
    end
  end


  describe '#generate_solution' do
    it 'for one step right addition equation' do
      equation = LinearEquation.new(Expression.new('x',
        [EquationStep.new(:add,5,:right)]),Expression.new(11))
      equation1 = LinearEquation.new(Expression.new('x',
        [EquationStep.new(:add,5,:right)]),Expression.new(11))
      equation2 = LinearEquation.new(Expression.new('x'),Expression.new(11,
          [EquationStep.new(:subtract,5,:right)]))
      equation3 = LinearEquation.new(Expression.new('x'),Expression.new(6))
      solutions = equation.generate_solution
      expect(solutions).to eq [equation1,equation2,equation3]
    end

    it 'for one step left division equation' do
      equation = LinearEquation.new(Expression.new('x',
        [EquationStep.new(:divide,15,:left)]),Expression.new(5))
      equation1 = LinearEquation.new(Expression.new('x',
        [EquationStep.new(:divide,15,:left)]),Expression.new(5))
      equation2 = LinearEquation.new(Expression.new(5,[EquationStep.new(:divide,15,:left)]),
        Expression.new('x'),)
      equation3 = LinearEquation.new(Expression.new(3),Expression.new('x'),)
      expect(equation.generate_solution).to eq [equation1,equation2,equation3]
    end

    it 'for two step linear equation with left subtraction' do
      equation = LinearEquation.new(Expression.new('x',
        [EquationStep.new(:multiply,2,:right),EquationStep.new(:subtract,14,:left)]),
        Expression.new(4))
      equation1 = LinearEquation.new(Expression.new('x',
        [EquationStep.new(:multiply,2,:right),EquationStep.new(:subtract,14,:left)]),
        Expression.new(4))
      equation2 = LinearEquation.new(Expression.new(4,[EquationStep.new(:subtract,14,:left)]),
        Expression.new('x',[EquationStep.new(:multiply,2,:right)]))
      equation3 = LinearEquation.new(Expression.new(10),
        Expression.new('x',[EquationStep.new(:multiply,2,:right)]))
      equation4 = LinearEquation.new(Expression.new(10,[EquationStep.new(:divide,2,:right)]),
        Expression.new('x'))
      equation5 = LinearEquation.new(Expression.new(5),Expression.new('x'))
      expect(equation.generate_solution).to eq [equation1,equation2,equation3,equation4,equation5]
    end
  end

  describe '#generate_latex' do
    context 'one step equations' do
      it 'for right addition question' do
        equation = LinearEquation.new(Expression.new('x',
          [EquationStep.new(:add,5,:right)]),Expression.new(11))
        expect(equation.generate_latex).to eq 'x+5&=11'
      end

      it 'for left addition question' do
        equation = LinearEquation.new(Expression.new('x',
          [EquationStep.new(:add,5,:left)]),Expression.new(11))
        expect(equation.generate_latex).to eq '5+x&=11'
      end

      it 'for right subtraction question' do
        equation = LinearEquation.new(Expression.new('x',
          [EquationStep.new(:subtract,5,:right)]),Expression.new(11))
        expect(equation.generate_latex).to eq 'x-5&=11'
      end

      it 'for left subtraction question' do
        equation = LinearEquation.new(Expression.new('x',
          [EquationStep.new(:subtract,15,:left)]),Expression.new(11))
        expect(equation.generate_latex).to eq '15-x&=11'
      end

      it 'for right multiplication question' do
        equation = LinearEquation.new(Expression.new('x',
          [EquationStep.new(:multiply,5,:right)]),Expression.new(45))
        expect(equation.generate_latex).to eq '5x&=45'
      end

      it 'for left multiplication question' do
        equation = LinearEquation.new(Expression.new('x',
          [EquationStep.new(:multiply,5,:left)]),Expression.new(15))
        expect(equation.generate_latex).to eq '5x&=15'
      end

      it 'for right division question' do
        equation = LinearEquation.new(Expression.new('x',
          [EquationStep.new(:divide,5,:right)]),Expression.new(11))
        expect(equation.generate_latex).to eq '\frac{x}{5}&=11'
      end

      it 'for left division question' do
        equation = LinearEquation.new(Expression.new('x',
          [EquationStep.new(:divide,15,:left)]),Expression.new(3))
        expect(equation.generate_latex).to eq '\frac{15}{x}&=3'
      end
    end

    context 'two step equations' do
      it 'for left add right multiply question' do
        equation = LinearEquation.new(Expression.new('x',
          [EquationStep.new(:add,15,:left),EquationStep.new(:multiply,2,:right)]),
          Expression.new(31))
        expect(equation.generate_latex).to eq "2\\left(15+x\\right)&=31"
      end

      it 'for left divide right subtract question' do
        equation = LinearEquation.new(Expression.new('x',
          [EquationStep.new(:divide,35,:left),EquationStep.new(:subtract,12,:right)]),
          Expression.new(416))
        expect(equation.generate_latex).to eq "\\frac{35}{x}-12&=416"
      end

      it 'for right divide left add question' do
        equation = LinearEquation.new(Expression.new('x',
          [EquationStep.new(:divide,3,:right),EquationStep.new(:add,12,:left)]),
          Expression.new(67))
        expect(equation.generate_latex).to eq "12+\\frac{x}{3}&=67"
      end

      it 'for right subtract left multiply question' do
        equation = LinearEquation.new(Expression.new('x',
          [EquationStep.new(:subtract,47,:right),EquationStep.new(:multiply,4,:left)]),
          Expression.new(15))
        expect(equation.generate_latex).to eq "4\\left(x-47\\right)&=15"
      end

      it 'for left divide left add question' do
        equation = LinearEquation.new(Expression.new('x',
          [EquationStep.new(:divide,352,:left),EquationStep.new(:add,16,:left)]),
          Expression.new(23))
        expect(equation.generate_latex).to eq "16+\\frac{352}{x}&=23"
      end

      it 'for left subtract left multiply question' do
        equation = LinearEquation.new(Expression.new('x',
          [EquationStep.new(:subtract,235,:left),EquationStep.new(:multiply,7,:left)]),
          Expression.new(125))
        expect(equation.generate_latex).to eq "7\\left(235-x\\right)&=125"
      end
    end

    context 'three step question' do
      it 'for left add right multiply right subtract question' do
        step1 = double(:step1, operation: :add, value: 13, orientation: :left)
        step2 = double(:step1, operation: :multiply, value: 5, orientation: :right)
        step3 = double(:step1, operation: :subtract, value: 23, orientation: :right)
        expression1 = double(:expression1, initial_value: 'x', steps: [step1,step2,step3])
        expression2 = double(:expression2, initial_value: 312, steps: [])
        equation = LinearEquation.new(expression1,expression2)
        expect(equation.generate_latex).to eq "5\\left(13+x\\right)-23&=312"
      end

      it 'for left subtract left divide right subtract question' do
        step1 = double(:step1, operation: :subtract, value: 135, orientation: :left)
        step2 = double(:step1, operation: :divide, value: 512, orientation: :left)
        step3 = double(:step1, operation: :subtract, value: 231, orientation: :right)
        expression1 = double(:expression1, initial_value: 'x', steps: [step1,step2,step3])
        expression2 = double(:expression2, initial_value: 23, steps: [])
        equation = LinearEquation.new(expression1,expression2)
        expect(equation.generate_latex).to eq "\\frac{512}{135-x}-231&=23"
      end
    end

    context 'four or more step question' do
      it 'for four step question' do
        step1 = double(:step1, operation: :add, value: 17, orientation: :left)
        step2 = double(:step1, operation: :multiply, value: 6, orientation: :left)
        step3 = double(:step1, operation: :add, value: 11, orientation: :left)
        step4 = double(:step1, operation: :divide, value: 548, orientation: :left)
        expression1 = double(:expression1, initial_value: 'x', steps: [step1,step2,step3,step4])
        expression2 = double(:expression2, initial_value: 4, steps: [])
        equation = LinearEquation.new(expression1,expression2)
        expect(equation.generate_latex).to eq "\\frac{548}{11+6\\left(17+x\\right)}&=4"
      end

      it 'for five step question' do
        step1 = double(:step1, operation: :multiply, value: 3, orientation: :left)
        step2 = double(:step1, operation: :subtract, value: 36, orientation: :left)
        step3 = double(:step1, operation: :divide, value: 72, orientation: :left)
        step4 = double(:step1, operation: :add, value: 11, orientation: :right)
        step5 = double(:step1, operation: :multiply, value: 8, orientation: :left)
        expression1 = double(:expression1, initial_value: 'x', steps: [step1,step2,step3,step4,step5])
        expression2 = double(:expression2, initial_value: 112, steps: [])
        equation = LinearEquation.new(expression1,expression2)
        expect(equation.generate_latex).to eq "8\\left(\\frac{72}{36-3x}+11\\right)&=112"
      end
    end
  end

  describe '#generate_solution_latex' do
    it 'for a one step question' do
      question = LinearEquation.new(Expression.new('x',
        [EquationStep.new(:subtract,47,:right)]),
        Expression.new(15))
      expect(question.generate_solution_latex).to eq "x-47&=15\\\\\nx&=15+47\\\\\nx&=62"
    end

  end

end
