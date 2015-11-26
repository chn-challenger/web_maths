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
        expect(@question.left_side).to eq [EquationStep.new(:subtract,8,:right)]
      end

      it 'has rigt side of an integer' do
        expect(@question.right_side).to eq 1
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
        expect(@question.left_side).to eq [EquationStep.new(:multiply,8)]
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

    context 'can generate random two step left division question' do
      shared_context 'two step question' do
        before(:all) do
          srand(132)
          @question = LinearEquation.generate_one_sided(2)
        end
      end

      include_context 'two step question'

      it 'has left side of one equation step' do
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

    context 'can generate random three step left division question' do
      shared_context 'three step question' do
        before(:all) do
          srand(123)
          @question = LinearEquation.generate_one_sided(3)
        end
      end

      include_context 'three step question'

      it 'has left side of one equation step' do
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

    context 'can generate random four step left division question' do
      shared_context 'four step question' do
        before(:all) do
          srand(200)
          @question = LinearEquation.generate_one_sided(4)
        end
      end

      include_context 'four step question'

      it 'has left side of one equation step' do
        expect(@question.left_side).to eq [EquationStep.new(:multiply,6,:left),
          EquationStep.new(:subtract,16,:right),EquationStep.new(:divide,4,:right),
          EquationStep.new(:subtract,43,:left)]
      end

      it 'has rigt side of an integer' do
        expect(@question.right_side).to eq 44
      end

      it 'has an integer solution' do
        expect(@question.solution).to eq 2
      end
    end

    context 'can generate random five step left division question' do
      shared_context 'five step question' do
        before(:all) do
          srand(300)
          @question = LinearEquation.generate_one_sided(5)
        end
      end

      include_context 'five step question'

      it 'has left side of one equation step' do
        expect(@question.left_side).to eq [EquationStep.new(:subtract,47,:left),
          EquationStep.new(:divide,4,:right),EquationStep.new(:subtract,54,:left),
          EquationStep.new(:multiply,4,:left),EquationStep.new(:add,5,:left)]
      end

      it 'has rigt side of an integer' do
        expect(@question.right_side).to eq 177
      end

      it 'has an integer solution' do
        expect(@question.solution).to eq 3
      end
    end
  end
end
