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
end
