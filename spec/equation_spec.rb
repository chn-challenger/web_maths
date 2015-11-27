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

  describe '#solution_next_step' do
    it 'returns next pair of steps one step right addition equation' do
      equation = Equation.new(Expression.new('x',
        [EquationStep.new(:add,5,:right)]),Expression.new(11))
      expected_returns = [Equation.new(Expression.new('x'),
        Expression.new(11,[EquationStep.new(:subtract,5,:right)])),
        Equation.new(Expression.new('x'),Expression.new(6))]
      expect(equation.solution_next_step).to eq expected_returns
    end

    it 'returns next pair of steps one step left addition equation' do
      equation = Equation.new(Expression.new('x',
        [EquationStep.new(:add,5,:left)]),Expression.new(11))
      expected_returns = [Equation.new(Expression.new('x'),
        Expression.new(11,[EquationStep.new(:subtract,5,:right)])),
        Equation.new(Expression.new('x'),Expression.new(6))]
      expect(equation.solution_next_step).to eq expected_returns
    end

    it 'returns next pair of steps one step right multiplication equation' do
      equation = Equation.new(Expression.new('x',
        [EquationStep.new(:multiply,5,:right)]),Expression.new(15))
      expected_returns = [Equation.new(Expression.new('x'),
        Expression.new(15,[EquationStep.new(:divide,5,:right)])),
        Equation.new(Expression.new('x'),Expression.new(3))]
      expect(equation.solution_next_step).to eq expected_returns
    end

    it 'returns next pair of steps one step left multiplication equation' do
      equation = Equation.new(Expression.new('x',
        [EquationStep.new(:multiply,5,:left)]),Expression.new(15))
      expected_returns = [Equation.new(Expression.new('x'),
        Expression.new(15,[EquationStep.new(:divide,5,:right)])),
        Equation.new(Expression.new('x'),Expression.new(3))]
      expect(equation.solution_next_step).to eq expected_returns
    end

    it 'returns next pair of steps one step right subtraction equation' do
      equation = Equation.new(Expression.new('x',
        [EquationStep.new(:subtract,5,:right)]),Expression.new(15))
      expected_returns = [Equation.new(Expression.new('x'),
        Expression.new(15,[EquationStep.new(:add,5,:right)])),
        Equation.new(Expression.new('x'),Expression.new(20))]
      expect(equation.solution_next_step).to eq expected_returns
    end

    it 'returns next pair of steps one step right division equation' do
      equation = Equation.new(Expression.new('x',
        [EquationStep.new(:divide,5,:right)]),Expression.new(15))
      expected_returns = [Equation.new(Expression.new('x'),
        Expression.new(15,[EquationStep.new(:multiply,5,:right)])),
        Equation.new(Expression.new('x'),Expression.new(75))]
      expect(equation.solution_next_step).to eq expected_returns
    end

    it 'returns next pair of steps one step left subtraction equation' do
      equation = Equation.new(Expression.new('x',
        [EquationStep.new(:subtract,21,:left)]),Expression.new(11))
      expected_returns = [Equation.new(Expression.new(11,[EquationStep.new(:subtract,21,:left)]),Expression.new('x')),
        Equation.new(Expression.new(10),Expression.new('x'))]
      expect(equation.solution_next_step).to eq expected_returns
    end

    it 'returns next pair of steps one step left division equation' do
      equation = Equation.new(Expression.new('x',
        [EquationStep.new(:divide,21,:left)]),Expression.new(7))
      expected_returns = [Equation.new(Expression.new(7,[EquationStep.new(:divide,21,:left)]),Expression.new('x')),
        Equation.new(Expression.new(3),Expression.new('x'))]
      expect(equation.solution_next_step).to eq expected_returns
    end

  end

  # describe '#generate_solution' do
  #   it 'for one step right addition equation' do
  #     step1 = EquationStep.new(:add,5,:right)
  #     left_side = Expression.new('x',[step1])
  #     right_side = Expression.new(11,[])
  #     equation = Equation.new(left_side,right_side)
  #     solution_array = [equation.dup,Equation.new('x',6)]
  #     expect(equation.generate_solution).to eq solution_array
  #   end
  # end

end
