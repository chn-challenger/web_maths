require './generators/equation'

describe Equation do
  describe '#initialize/new' do
    let(:equation){described_class.new}

    it 'initialize with a left side expression' do
      expect(equation.left_side).to eq Expression.new
    end

    it 'initialize with a right side expression' do
      expect(equation.right_side).to eq Expression.new
    end

    it 'initialize with a solution hash' do
      expect(equation.solution).to be {}
    end
  end

  describe '#==' do
    it 'can determine equivalence of two default equations' do
      equation1 = Equation.new
      equation2 = Equation.new
      expect(equation1).to eq equation2
    end

    it 'can determine equivalence of two equations with steps' do
      equation1 = Equation.new(Expression.new('x',
        [EquationStep.new(:multiply,2,:right),EquationStep.new(:subtract,14,:left)]),
        Expression.new(4))
      equation2 = Equation.new(Expression.new('x',
        [EquationStep.new(:multiply,2,:right),EquationStep.new(:subtract,14,:left)]),
        Expression.new(4))
      expect(equation1).to eq equation2
    end
    it 'can determine non-equivalence of two equations with steps' do
      equation1 = Equation.new(Expression.new('x',
        [EquationStep.new(:add,2,:right),EquationStep.new(:subtract,14,:left)]),
        Expression.new(4))
      equation2 = Equation.new(Expression.new('x',
        [EquationStep.new(:multiply,2,:right),EquationStep.new(:subtract,14,:left)]),
        Expression.new(4))
      expect(equation1).not_to eq equation2
    end
  end

  describe '#copy' do
    shared_context 'self copy' do
      before(:all) do
        @step1 = EquationStep.new(:add,5,:left)
        @step2 = EquationStep.new(:subtract,7,:right)
        @step3 = EquationStep.new(:multiply,3,:left)
        @step4 = EquationStep.new(:divide,4,:right)
        @expression1 = Expression.new(3,[@step1,@step2])
        @expression2 = Expression.new('x',[@step3,@step4])
        @equation = Equation.new(@expression1,@expression2)
        @equation_copy = @equation.copy
      end
    end

    include_context 'self copy'

    it 'returns an instance of the class with same states' do
      expect(@equation).to eq @equation_copy
    end

    it 'the copied instance states have different object_ids example' do
      copied_equation_state_object_id = @equation_copy.left_side.steps.first.object_id
      expect(@equation.left_side.steps.first.object_id).not_to eq copied_equation_state_object_id
    end

    it 'returns a different instance of the class with same states' do
      expect(@equation.object_id).not_to eq @equation_copy.object_id
    end
  end
end
