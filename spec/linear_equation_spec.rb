require './generators/linear_equation'

describe LinearEquation do
  describe '#initialize/new' do
    let(:linear_equation){described_class.new('left','right',10)}

    it 'has a left hand side' do
      expect(linear_equation.left_side).to eq 'left'
    end

    it 'has a right hand side' do
      expect(linear_equation.right_side).to eq 'right'
    end

    it 'has a solution' do
      expect(linear_equation.solution).to eq 10
    end
  end

  describe '#generate_one_sided' do
    context 'can generate random one step left addition question' do
      shared_context 'one step question' do
        before(:all) do
          srand(102)
          @question = LinearEquation.generate_one_sided()
        end
      end

      include_context 'one step question'

      it 'has left side of one equation step' do
        expect(@question.left_side).to eq [EquationStep.new(:add,49,:left)]
      end

      it 'has rigt side of an integer' do
        expect(@question.right_side).to eq 51
      end

      it 'has an integer solution' do
        expect(@question.solution).to eq 2
      end
    end

    context 'can generate random one step right addition question' do
      shared_context 'one step question' do
        before(:all) do
          srand(105)
          @question = LinearEquation.generate_one_sided()
        end
      end

      include_context 'one step question'

      it 'has left side of one equation step' do
        expect(@question.left_side).to eq [EquationStep.new(:add,38,:right)]
      end

      it 'has rigt side of an integer' do
        expect(@question.right_side).to eq 40
      end

      it 'has an integer solution' do
        expect(@question.solution).to eq 2
      end
    end

    context 'can generate random one step left subtraction question' do
      shared_context 'one step question' do
        before(:all) do
          srand(106)
          @question = LinearEquation.generate_one_sided()
        end
      end

      include_context 'one step question'

      it 'has left side of one equation step' do
        expect(@question.left_side).to eq [EquationStep.new(:subtract,21,:left)]
      end

      it 'has rigt side of an integer' do
        expect(@question.right_side).to eq 12
      end

      it 'has an integer solution' do
        expect(@question.solution).to eq 9
      end
    end

    context 'can generate random one step right subtraction question' do
      shared_context 'one step question' do
        before(:all) do
          srand(103)
          @question = LinearEquation.generate_one_sided()
        end
      end

      include_context 'one step question'

      it 'has left side of one equation step' do
        expect(@question.left_side).to eq [EquationStep.new(:subtract,3,:right)]
      end

      it 'has rigt side of an integer' do
        expect(@question.right_side).to eq 6
      end

      it 'has an integer solution' do
        expect(@question.solution).to eq 9
      end
    end

    context 'can generate random one step multiplication question' do
      shared_context 'one step question' do
        before(:all) do
          srand(111)
          @question = LinearEquation.generate_one_sided()
        end
      end

      include_context 'one step question'

      it 'has left side of one equation step' do
        expect(@question.left_side).to eq [EquationStep.new(:multiply,8,:left)]
      end

      it 'has rigt side of an integer' do
        expect(@question.right_side).to eq 48
      end

      it 'has an integer solution' do
        expect(@question.solution).to eq 6
      end
    end

    context 'can generate random one step right division question' do
      shared_context 'one step question' do
        before(:all) do
          srand(117)
          @question = LinearEquation.generate_one_sided()
        end
      end

      include_context 'one step question'

      it 'has left side of one equation step' do
        expect(@question.left_side).to eq [EquationStep.new(:divide,2,:right)]
      end

      it 'has rigt side of an integer' do
        expect(@question.right_side).to eq 1
      end

      it 'has an integer solution' do
        expect(@question.solution).to eq 2
      end
    end

    context 'can generate random one step left division question' do
      shared_context 'one step question' do
        before(:all) do
          srand(132)
          @question = LinearEquation.generate_one_sided()
        end
      end

      include_context 'one step question'

      it 'has left side of one equation step' do
        expect(@question.left_side).to eq [EquationStep.new(:divide,12,:left)]
      end

      it 'has rigt side of an integer' do
        expect(@question.right_side).to eq 4
      end

      it 'has an integer solution' do
        expect(@question.solution).to eq 3
      end
    end

    context 'can generate random two step question' do
      shared_context 'two step question' do
        before(:all) do
          srand(132)
          @question = LinearEquation.generate_one_sided(2)
        end
      end

      include_context 'two step question'

      it 'has left side of two equation step' do
        expect(@question.left_side).to eq [EquationStep.new(:divide,12,:left),
          EquationStep.new(:add,36,:right)]
      end

      it 'has rigt side of an integer' do
        expect(@question.right_side).to eq 40
      end

      it 'has an integer solution' do
        expect(@question.solution).to eq 3
      end
    end

    context 'can generate random three step question' do
      shared_context 'three step question' do
        before(:all) do
          srand(123)
          @question = LinearEquation.generate_one_sided(3)
        end
      end

      include_context 'three step question'

      it 'has left side of three equation step' do
        expect(@question.left_side).to eq [EquationStep.new(:multiply,3,:left),
          EquationStep.new(:subtract,36,:left),EquationStep.new(:divide,72,:left)]
      end

      it 'has rigt side of an integer' do
        expect(@question.right_side).to eq 3
      end

      it 'has an integer solution' do
        expect(@question.solution).to eq 4
      end
    end

    context 'can generate random four step question' do
      shared_context 'four step question' do
        before(:all) do
          srand(200)
          @question = LinearEquation.generate_one_sided(4)
        end
      end

      include_context 'four step question'

      it 'has left side of four equation step' do
        expect(@question.left_side).to eq [EquationStep.new(:multiply,6,:left),
          EquationStep.new(:subtract,11,:right),EquationStep.new(:divide,8,:left),
          EquationStep.new(:add,3,:left)]
      end

      it 'has right side of an integer' do
        expect(@question.right_side).to eq 11
      end

      it 'has an integer solution' do
        expect(@question.solution).to eq 2
      end
    end

    context 'can generate random five step question' do
      shared_context 'five step question' do
        before(:all) do
          srand(300)
          @question = LinearEquation.generate_one_sided(5)
        end
      end

      include_context 'five step question'

      it 'has left side of five equation step' do
        expect(@question.left_side).to eq [EquationStep.new(:subtract,47,:left),
          EquationStep.new(:divide,4,:right),EquationStep.new(:subtract,54,:left),
          EquationStep.new(:multiply,8,:left),EquationStep.new(:add,5,:left)]
      end

      it 'has rigt side of an integer' do
        expect(@question.right_side).to eq 349
      end

      it 'has an integer solution' do
        expect(@question.solution).to eq 3
      end
    end
  end

  describe '#generate_one_sided_questions' do
    it 'can generate one one-sided question with two steps' do
      srand(100)
      questions = LinearEquation.generate_one_sided_questions(1,2)
      expected_questions = []
      question_1_left_side = [EquationStep.new(:divide,5,:right),EquationStep.new(:subtract,14,:left)]
      question_1 = LinearEquation.new(question_1_left_side,12,10)
      expected_questions << question_1
      expect(questions).to eq expected_questions
    end

    it 'can generate two one-sided question with three steps' do
      srand(200)
      questions = LinearEquation.generate_one_sided_questions(2,3)
      expected_questions = []
      question_1_left_side = [EquationStep.new(:multiply,6,:left),
        EquationStep.new(:subtract,11,:right),EquationStep.new(:divide,8,:left)]
      question_1 = LinearEquation.new(question_1_left_side,8,2)
      expected_questions << question_1
      question_2_left_side = [EquationStep.new(:subtract,5,:right),
        EquationStep.new(:divide,5,:right),EquationStep.new(:subtract,26,:left)]
      question_2 = LinearEquation.new(question_2_left_side,25,10)
      expected_questions << question_2
      expect(questions).to eq expected_questions
    end
  end

  describe '#convert_to_general_equation' do
    it 'can convert a one step one-sided to an equivalent general equation' do
      left_side = [EquationStep.new(:add,5,:right)]
      linear_equation = LinearEquation.new(left_side,12,7)
      generation_equation = linear_equation.convert_to_general_equation('x')
      expect(generation_equation).to eq Equation.new(Expression.new('x',[EquationStep.new(:add,5,:right)]),Expression.new(12))
    end

    it 'can convert a random one step one-sided to an equivalent general equation' do
      srand(1200)
      linear_equation = LinearEquation.generate_one_sided()
      generation_equation = linear_equation.convert_to_general_equation('x')
      expect(generation_equation).to eq Equation.new(Expression.new('x',
        [EquationStep.new(:subtract,28,:left)]),Expression.new(23))
    end

    it 'can convert a random two step one-sided to an equivalent general equation' do
      srand(1300)
      linear_equation = LinearEquation.generate_one_sided(2)
      generation_equation = linear_equation.convert_to_general_equation('x')
      expect(generation_equation).to eq Equation.new(Expression.new('x',
        [EquationStep.new(:add,49,:right),EquationStep.new(:multiply,6,:left)]),
        Expression.new(312))
    end
  end
end
