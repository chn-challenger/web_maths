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
        expect(questions).to eq [expected_question]
      end

      it 'one 1 right addition step question' do
        srand(110)
        questions = LinearEquation.generate
        left_side = Expression.new('x',[EquationStep.new(:add,27,:right)])
        right_side= Expression.new(29)
        solution = {"x"=>2}
        expected_question = LinearEquation.new(left_side,right_side,solution)
        expect(questions).to eq [expected_question]
      end

      it 'one 1 left subtraction step question' do
        srand(137)
        questions = LinearEquation.generate
        left_side = Expression.new('x',[EquationStep.new(:subtract,21,:left)])
        right_side= Expression.new(13)
        solution = {"x"=>8}
        expected_question = LinearEquation.new(left_side,right_side,solution)
        expect(questions).to eq [expected_question]
      end

      it 'one 1 right subtraction step question' do
        srand(141)
        questions = LinearEquation.generate
        left_side = Expression.new('x',[EquationStep.new(:subtract,5,:right)])
        right_side= Expression.new(3)
        solution = {"x"=>8}
        expected_question = LinearEquation.new(left_side,right_side,solution)
        expect(questions).to eq [expected_question]
      end

      it 'one 1 multiplication step question' do
        srand(123)
        questions = LinearEquation.generate
        left_side = Expression.new('x',[EquationStep.new(:multiply,3,:left)])
        right_side= Expression.new(12)
        solution = {"x"=>4}
        expected_question = LinearEquation.new(left_side,right_side,solution)
        expect(questions).to eq [expected_question]
      end

      it 'one 1 left division step question' do
        srand(115)
        questions = LinearEquation.generate
        left_side = Expression.new('x',[EquationStep.new(:divide,32,:left)])
        right_side= Expression.new(8)
        solution = {"x"=>4}
        expected_question = LinearEquation.new(left_side,right_side,solution)
        expect(questions).to eq [expected_question]
      end

      it 'one 1 right division step question' do
        srand(100)
        questions = LinearEquation.generate
        left_side = Expression.new('x',[EquationStep.new(:divide,5,:right)])
        right_side= Expression.new(2)
        solution = {"x"=>10}
        expected_question = LinearEquation.new(left_side,right_side,solution)
        expect(questions).to eq [expected_question]
      end
    end

    context 'one two-step question' do
      it 'multiply then right subtract question' do
        srand(200)
        questions = LinearEquation.generate(1,{steps:2,solution_range:10,variable:'x'})
        step1 = EquationStep.new(:multiply,6,:left)
        step2 = EquationStep.new(:subtract,11,:right)
        left_side = Expression.new('x',[step1,step2])
        right_side= Expression.new(1)
        solution = {"x"=>2}
        expected_question = LinearEquation.new(left_side,right_side,solution)
        expect(questions).to eq [expected_question]
      end

      it 'left subtract then right divide question' do
        srand(300)
        questions = LinearEquation.generate(1,{steps:2,solution_range:10,variable:'x'})
        step1 = EquationStep.new(:subtract,47,:left)
        step2 = EquationStep.new(:divide,4,:right)
        left_side = Expression.new('x',[step1,step2])
        right_side= Expression.new(11)
        solution = {"x"=>3}
        expected_question = LinearEquation.new(left_side,right_side,solution)
        expect(questions).to eq [expected_question]
      end

      it 'right add then right divide question' do
        srand(400)
        questions = LinearEquation.generate(1,{steps:2,solution_range:10,variable:'x'})
        step1 = EquationStep.new(:add,10,:right)
        step2 = EquationStep.new(:divide,3,:right)
        left_side = Expression.new('x',[step1,step2])
        right_side= Expression.new(5)
        solution = {"x"=>5}
        expected_question = LinearEquation.new(left_side,right_side,solution)
        expect(questions).to eq [expected_question]
      end

      it 'left subtract then left multiply question' do
        srand(500)
        questions = LinearEquation.generate(1,{steps:2,solution_range:10,variable:'x'})
        step1 = EquationStep.new(:subtract,42,:left)
        step2 = EquationStep.new(:multiply,9,:left)
        left_side = Expression.new('x',[step1,step2])
        right_side= Expression.new(297)
        solution = {"x"=>9}
        expected_question = LinearEquation.new(left_side,right_side,solution)
        expect(questions).to eq [expected_question]
      end

      it 'left subtract then left multiply question' do
        srand(600)
        questions = LinearEquation.generate(1,{steps:2,solution_range:10,variable:'x'})
        step1 = EquationStep.new(:subtract,4,:right)
        step2 = EquationStep.new(:divide,2,:right)
        left_side = Expression.new('x',[step1,step2])
        right_side= Expression.new(1)
        solution = {"x"=>6}
        expected_question = LinearEquation.new(left_side,right_side,solution)
        expect(questions).to eq [expected_question]
      end
    end

    context 'one three-step question' do
      it 'right divide left subtract left multiply question' do
        srand(100)
        questions = LinearEquation.generate(1,{steps:3,solution_range:10,variable:'x'})
        step1 = EquationStep.new(:divide,5,:right)
        step2 = EquationStep.new(:subtract,14,:left)
        step3 = EquationStep.new(:multiply,6,:left)
        left_side = Expression.new('x',[step1,step2,step3])
        right_side= Expression.new(72)
        solution = {"x"=>10}
        expected_question = LinearEquation.new(left_side,right_side,solution)
        expect(questions).to eq [expected_question]
      end

      it 'left multiply right subtract left divide question' do
        srand(200)
        questions = LinearEquation.generate(1,{steps:3,solution_range:10,variable:'x'})
        step1 = EquationStep.new(:multiply,6,:left)
        step2 = EquationStep.new(:subtract,11,:right)
        step3 = EquationStep.new(:divide,8,:left)
        left_side = Expression.new('x',[step1,step2,step3])
        right_side= Expression.new(8)
        solution = {"x"=>2}
        expected_question = LinearEquation.new(left_side,right_side,solution)
        expect(questions).to eq [expected_question]
      end

      it 'left subtract right divide left subtract question' do
        srand(300)
        questions = LinearEquation.generate(1,{steps:3,solution_range:10,variable:'x'})
        step1 = EquationStep.new(:subtract,47,:left)
        step2 = EquationStep.new(:divide,4,:right)
        step3 = EquationStep.new(:subtract,54,:left)
        left_side = Expression.new('x',[step1,step2,step3])
        right_side= Expression.new(43)
        solution = {"x"=>3}
        expected_question = LinearEquation.new(left_side,right_side,solution)
        expect(questions).to eq [expected_question]
      end
    end

    context 'one four-step question' do
      it 'right divide left subtract left multiply right add question' do
        srand(100)
        questions = LinearEquation.generate(1,{steps:4,solution_range:10,variable:'x'})
        step1 = EquationStep.new(:divide,5,:right)
        step2 = EquationStep.new(:subtract,14,:left)
        step3 = EquationStep.new(:multiply,6,:left)
        step4 = EquationStep.new(:add,4,:right)
        left_side = Expression.new('x',[step1,step2,step3,step4])
        right_side= Expression.new(76)
        solution = {"x"=>10}
        expected_question = LinearEquation.new(left_side,right_side,solution)
        expect(questions).to eq [expected_question]
      end

      it 'left multiply right subtract left divide left add question' do
        srand(200)
        questions = LinearEquation.generate(1,{steps:4,solution_range:10,variable:'x'})
        step1 = EquationStep.new(:multiply,6,:left)
        step2 = EquationStep.new(:subtract,11,:right)
        step3 = EquationStep.new(:divide,8,:left)
        step4 = EquationStep.new(:add,3,:left)
        left_side = Expression.new('x',[step1,step2,step3,step4])
        right_side= Expression.new(11)
        solution = {"x"=>2}
        expected_question = LinearEquation.new(left_side,right_side,solution)
        expect(questions).to eq [expected_question]
      end
    end

    context 'one five-step question' do
      it 'right divide left subtract left multiply right add left multiply question' do
        srand(100)
        questions = LinearEquation.generate(1,{steps:5,solution_range:10,variable:'x'})
        step1 = EquationStep.new(:divide,5,:right)
        step2 = EquationStep.new(:subtract,14,:left)
        step3 = EquationStep.new(:multiply,6,:left)
        step4 = EquationStep.new(:add,4,:right)
        step5 = EquationStep.new(:multiply,8,:left)
        left_side = Expression.new('x',[step1,step2,step3,step4,step5])
        right_side= Expression.new(608)
        solution = {"x"=>10}
        expected_question = LinearEquation.new(left_side,right_side,solution)
        expect(questions).to eq [expected_question]
      end
    end

    context 'two multi-step questions' do
      it 'two four-step questions' do
        srand(100)
        questions = LinearEquation.generate(2,{steps:4,solution_range:10,variable:'x'})
        step1 = EquationStep.new(:divide,5,:right)
        step2 = EquationStep.new(:subtract,14,:left)
        step3 = EquationStep.new(:multiply,6,:left)
        step4 = EquationStep.new(:add,4,:right)
        left_side = Expression.new('x',[step1,step2,step3,step4])
        right_side= Expression.new(76)
        solution = {"x"=>10}
        expected_question1 = LinearEquation.new(left_side,right_side,solution)
        step1 = EquationStep.new(:multiply,2,:left)
        step2 = EquationStep.new(:add,38,:right)
        step3 = EquationStep.new(:divide,184,:left)
        step4 = EquationStep.new(:add,11,:right)
        left_side = Expression.new('x',[step1,step2,step3,step4])
        right_side= Expression.new(15)
        solution = {"x"=>4}
        expected_question2 = LinearEquation.new(left_side,right_side,solution)
        expect(questions).to eq [expected_question1,expected_question2]
      end

      it 'three three-step questions' do
        srand(100)
        questions = LinearEquation.generate(3,{steps:3,solution_range:10,variable:'x'})
        step1 = EquationStep.new(:divide,5,:right)
        step2 = EquationStep.new(:subtract,14,:left)
        step3 = EquationStep.new(:multiply,6,:left)
        left_side = Expression.new('x',[step1,step2,step3])
        right_side= Expression.new(72)
        solution = {"x"=>10}
        expected_question1 = LinearEquation.new(left_side,right_side,solution)
        step1 = EquationStep.new(:add,16,:left)
        step2 = EquationStep.new(:multiply,2,:left)
        step3 = EquationStep.new(:add,38,:right)
        left_side = Expression.new('x',[step1,step2,step3])
        right_side= Expression.new(78)
        solution = {"x"=>4}
        expected_question2 = LinearEquation.new(left_side,right_side,solution)
        step1 = EquationStep.new(:add,24,:right)
        step2 = EquationStep.new(:multiply,6,:left)
        step3 = EquationStep.new(:add,3,:right)
        left_side = Expression.new('x',[step1,step2,step3])
        right_side= Expression.new(159)
        solution = {"x"=>2}
        expected_question3 = LinearEquation.new(left_side,right_side,solution)
        expect(questions).to eq [expected_question1,expected_question2,expected_question3]
      end

      it 'four two-step questions' do
        srand(100)
        questions = LinearEquation.generate(4,{steps:2,solution_range:10,variable:'x'})
        step1 = EquationStep.new(:divide,5,:right)
        step2 = EquationStep.new(:subtract,14,:left)
        left_side = Expression.new('x',[step1,step2])
        right_side= Expression.new(12)
        solution = {"x"=>10}
        expected_question1 = LinearEquation.new(left_side,right_side,solution)
        step1 = EquationStep.new(:divide,24,:left)
        step2 = EquationStep.new(:add,50,:left)
        left_side = Expression.new('x',[step1,step2])
        right_side= Expression.new(54)
        solution = {"x"=>6}
        expected_question2 = LinearEquation.new(left_side,right_side,solution)
        step1 = EquationStep.new(:add,18,:right)
        step2 = EquationStep.new(:divide,4,:right)
        left_side = Expression.new('x',[step1,step2])
        right_side= Expression.new(7)
        solution = {"x"=>10}
        expected_question3 = LinearEquation.new(left_side,right_side,solution)
        step1 = EquationStep.new(:divide,48,:left)
        step2 = EquationStep.new(:subtract,3,:right)
        left_side = Expression.new('x',[step1,step2])
        right_side= Expression.new(3)
        solution = {"x"=>8}
        expected_question4 = LinearEquation.new(left_side,right_side,solution)
        expect(questions).to eq [expected_question1,expected_question2,
          expected_question3,expected_question4]
      end
    end
  end
end
