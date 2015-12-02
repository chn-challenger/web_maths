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
end
