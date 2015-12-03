require './generators/expression'

describe Expression do
  describe '#initialize/new' do
    let(:expression){described_class.new()}

    it 'has with a starting value' do
      expect(expression.initial_value).to eq 0
    end

    it 'has with an array of equation-steps' do
      expect(expression.steps).to eq []
    end
  end

  describe '#==' do
    it 'asserts absolute equality of two expressions' do
      expression1 = Expression.new('x',[EquationStep.new(:add,5,:left)])
      expression2 = Expression.new('x',[EquationStep.new(:add,5,:left)])
      expect(expression1).to eq expression2
    end

    it 'asserts inequality of two expressions' do
      expression1 = Expression.new('x',[EquationStep.new(:add,5,:left)])
      expression2 = Expression.new('x',[])
      expect(expression1).not_to eq expression2
    end
  end

  describe '#copy' do
    context 'making a copy of self when initial value is a integer' do
      shared_context 'self copy' do
        before(:all) do
          @step1 = EquationStep.new(:add,5,:left)
          @step2 = EquationStep.new(:subtract,7,:right)
          @expression = Expression.new(3,[@step1,@step2])
          @expression_copy = @expression.copy
        end
      end

      include_context 'self copy'

      it 'returns an instance of the class with same states' do
        expect(@expression).to eq @expression_copy
      end

      it 'returns a different instance of the class with same states' do
        expect(@expression.object_id).not_to eq @expression_copy.object_id
      end
    end

    context 'making a copy of self when initial value is a string' do
      shared_context 'self copy' do
        before(:all) do
          @step1 = EquationStep.new(:add,5,:left)
          @step2 = EquationStep.new(:subtract,7,:right)
          @expression = Expression.new('x',[@step1,@step2])
          @expression_copy = @expression.copy
        end
      end

      include_context 'self copy'

      it 'returns an instance of the class with same states' do
        expect(@expression).to eq @expression_copy
      end

      it 'returns a different instance of the class with same states' do
        expect(@expression.object_id).not_to eq @expression_copy.object_id
      end

      it 'initial values are different string objects of the same string' do
        expect(@expression.initial_value.object_id).not_to eq @expression_copy.initial_value.object_id
      end
    end
  end

  describe '#evaluate_next_step' do
    it 'with a string initial value to a copy of itself' do
      expression = Expression.new('x',[EquationStep.new(:add,5,:left)])
      expect(expression.evaluate_next_step).to eq expression
    end

    it 'with no steps to a copy of itself' do
      expression = Expression.new(11,[])
      expect(expression.evaluate_next_step).to eq expression
    end

    it 'one step expression to a final value' do
      expression = Expression.new(15,[EquationStep.new(:add,5,:left)])
      expect(expression.evaluate_next_step).to eq Expression.new(20,[])
    end

    it 'two step expression to a new initial value and a step' do
      expression = Expression.new(15,[EquationStep.new(:add,5,:left),EquationStep.new(:multiply,5,:left)])
      expect(expression.evaluate_next_step).to eq Expression.new(20,[EquationStep.new(:multiply,5,:left)])
    end

    it 'three step expression to a new initial value and two steps' do
      expression = Expression.new(15,[EquationStep.new(:add,5,:left),EquationStep.new(:multiply,5,:left),EquationStep.new(:subtract,15,:left)])
      expect(expression.evaluate_next_step).to eq Expression.new(20,[EquationStep.new(:multiply,5,:left),EquationStep.new(:subtract,15,:left)])
      expect(expression).to eq Expression.new(15,[EquationStep.new(:add,5,:left),EquationStep.new(:multiply,5,:left),EquationStep.new(:subtract,15,:left)])
    end

    it 'apply three times to a three step expression to give final value' do
      expression = Expression.new(15,[EquationStep.new(:add,5,:left),EquationStep.new(:multiply,5,:left),EquationStep.new(:subtract,15,:right)])
      final_expression = expression.evaluate_next_step
      2.times {final_expression = final_expression.evaluate_next_step}
      expect(final_expression.initial_value).to eq 85
    end
  end

  describe '#expand_bracket' do
    it 'expands a bracket with 2 step' do
      expression = Expression.new('x',[EquationStep.new(:add,3,:right),
        EquationStep.new(:multiply,2,:left)])
      expr_2x = Expression.new('x',[EquationStep.new(:multiply,2,:left)])
      expected_expression = Expression.new(expr_2x,[EquationStep.new(:add,6,:right)])
      expect(expression.expand_bracket).to eq expected_expression
    end

    it 'expands a bracket with 3 step' do
      expression = Expression.new('x',[EquationStep.new(:subtract,25,:left),EquationStep.new(:add,3,:right),
        EquationStep.new(:multiply,2,:left)])
      expr_2x = Expression.new('x',[EquationStep.new(:multiply,2,:left)])
      expected_expression = Expression.new(expr_2x,[EquationStep.new(:subtract,50,:left),
        EquationStep.new(:add,6,:right)])
      expect(expression.expand_bracket).to eq expected_expression
    end

  end

end
