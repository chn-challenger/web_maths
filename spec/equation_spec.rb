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

  describe '#solution_next_step_old' do
    it 'returns next pair of steps one step right addition equation' do
      equation = Equation.new(Expression.new('x',
        [EquationStep.new(:add,5,:right)]),Expression.new(11))
      expected_returns = [Equation.new(Expression.new('x'),
        Expression.new(11,[EquationStep.new(:subtract,5,:right)])),
        Equation.new(Expression.new('x'),Expression.new(6))]
      expect(equation.solution_next_step_old).to eq expected_returns
    end

    it 'returns next pair of steps one step left addition equation' do
      equation = Equation.new(Expression.new('x',
        [EquationStep.new(:add,5,:left)]),Expression.new(11))
      expected_returns = [Equation.new(Expression.new('x'),
        Expression.new(11,[EquationStep.new(:subtract,5,:right)])),
        Equation.new(Expression.new('x'),Expression.new(6))]
      expect(equation.solution_next_step_old).to eq expected_returns
    end

    it 'returns next pair of steps one step right multiplication equation' do
      equation = Equation.new(Expression.new('x',
        [EquationStep.new(:multiply,5,:right)]),Expression.new(15))
      expected_returns = [Equation.new(Expression.new('x'),
        Expression.new(15,[EquationStep.new(:divide,5,:right)])),
        Equation.new(Expression.new('x'),Expression.new(3))]
      expect(equation.solution_next_step_old).to eq expected_returns
    end

    it 'returns next pair of steps one step left multiplication equation' do
      equation = Equation.new(Expression.new('x',
        [EquationStep.new(:multiply,5,:left)]),Expression.new(15))
      expected_returns = [Equation.new(Expression.new('x'),
        Expression.new(15,[EquationStep.new(:divide,5,:right)])),
        Equation.new(Expression.new('x'),Expression.new(3))]
      expect(equation.solution_next_step_old).to eq expected_returns
    end

    it 'returns next pair of steps one step right subtraction equation' do
      equation = Equation.new(Expression.new('x',
        [EquationStep.new(:subtract,5,:right)]),Expression.new(15))
      expected_returns = [Equation.new(Expression.new('x'),
        Expression.new(15,[EquationStep.new(:add,5,:right)])),
        Equation.new(Expression.new('x'),Expression.new(20))]
      expect(equation.solution_next_step_old).to eq expected_returns
    end

    it 'returns next pair of steps one step right division equation' do
      equation = Equation.new(Expression.new('x',
        [EquationStep.new(:divide,5,:right)]),Expression.new(15))
      expected_returns = [Equation.new(Expression.new('x'),
        Expression.new(15,[EquationStep.new(:multiply,5,:right)])),
        Equation.new(Expression.new('x'),Expression.new(75))]
      expect(equation.solution_next_step_old).to eq expected_returns
    end

    it 'returns next pair of steps one step left subtraction equation' do
      equation = Equation.new(Expression.new('x',
        [EquationStep.new(:subtract,21,:left)]),Expression.new(11))
      expected_returns = [Equation.new(Expression.new(11,[EquationStep.new(:subtract,21,:left)]),Expression.new('x')),
        Equation.new(Expression.new(10),Expression.new('x'))]
      expect(equation.solution_next_step_old).to eq expected_returns
    end

    it 'returns next pair of steps one step left division equation' do
      equation = Equation.new(Expression.new('x',
        [EquationStep.new(:divide,21,:left)]),Expression.new(7))
      expected_returns = [Equation.new(Expression.new(7,[EquationStep.new(:divide,21,:left)]),Expression.new('x')),
        Equation.new(Expression.new(3),Expression.new('x'))]
      expect(equation.solution_next_step_old).to eq expected_returns
    end

    it 'returns next pair of steps of a two step equation' do
      equation = Equation.new(Expression.new('x',
        [EquationStep.new(:multiply,3,:left),EquationStep.new(:subtract,10,:right)]),Expression.new(11))
      equation1 = Equation.new(Expression.new('x',
        [EquationStep.new(:multiply,3,:left)]),Expression.new(11,EquationStep.new(:add,10,:right)))
      equation2 = Equation.new(Expression.new('x',
        [EquationStep.new(:multiply,3,:left)]),Expression.new(21))
      expect(equation.solution_next_step_old).to eq [equation1,equation2]
    end
  end

  describe '#solution_next_step' do
    it 'returns 1st step of a one step right addition equation' do
      equation = Equation.new(Expression.new('x',
        [EquationStep.new(:add,5,:right)]),Expression.new(11))
      arranged_equation = Equation.new(Expression.new('x'),
        Expression.new(11,[EquationStep.new(:subtract,5,:right)]))
      expect(equation.solution_next_step).to eq arranged_equation
    end

    it 'returns 2nd step of a one step right addition equation' do
      equation = Equation.new(Expression.new('x'),
        Expression.new(11,[EquationStep.new(:subtract,5,:right)]))
      arranged_equation = Equation.new(Expression.new('x'),
        Expression.new(6))
      expect(equation.solution_next_step).to eq arranged_equation
    end

    it 'returns 1st step of a one step left addition equation' do
      equation = Equation.new(Expression.new('x',
        [EquationStep.new(:add,5,:left)]),Expression.new(11))
      arranged_equation = Equation.new(Expression.new('x'),
        Expression.new(11,[EquationStep.new(:subtract,5,:right)]))
      expect(equation.solution_next_step).to eq arranged_equation
    end

    it 'returns 2nd step of a one step left addition equation' do
      equation = Equation.new(Expression.new('x'),
        Expression.new(11,[EquationStep.new(:subtract,5,:right)]))
      arranged_equation = Equation.new(Expression.new('x'),
        Expression.new(6))
      expect(equation.solution_next_step).to eq arranged_equation
    end

    it 'returns 1st step of a one step right multiplication equation' do
      equation = Equation.new(Expression.new('x',
        [EquationStep.new(:multiply,5,:right)]),Expression.new(15))
      arranged_equation = Equation.new(Expression.new('x'),
        Expression.new(15,[EquationStep.new(:divide,5,:right)]))
      expect(equation.solution_next_step).to eq arranged_equation
    end

    it 'returns 2nd step of a one step right multiplication equation' do
      equation = Equation.new(Expression.new('x'),
        Expression.new(15,[EquationStep.new(:divide,5,:right)]))
      arranged_equation = Equation.new(Expression.new('x'),
        Expression.new(3))
      expect(equation.solution_next_step).to eq arranged_equation
    end

    it 'returns 1st step of a one step left multiplication equation' do
      equation = Equation.new(Expression.new('x',
        [EquationStep.new(:multiply,5,:left)]),Expression.new(15))
      arranged_equation = Equation.new(Expression.new('x'),
        Expression.new(15,[EquationStep.new(:divide,5,:right)]))
      expect(equation.solution_next_step).to eq arranged_equation
    end

    it 'returns 2nd step of a one step left multiplication equation' do
      equation = Equation.new(Expression.new('x'),
        Expression.new(15,[EquationStep.new(:divide,5,:right)]))
      arranged_equation = Equation.new(Expression.new('x'),
        Expression.new(3))
      expect(equation.solution_next_step).to eq arranged_equation
    end

    it 'returns 1st step of a one step right subtraction equation' do
      equation = Equation.new(Expression.new('x',
        [EquationStep.new(:subtract,5,:right)]),Expression.new(15))
      arranged_equation = Equation.new(Expression.new('x'),
        Expression.new(15,[EquationStep.new(:add,5,:right)]))
      expect(equation.solution_next_step).to eq arranged_equation
    end

    it 'returns 2nd step of a one step right subtraction equation' do
      equation = Equation.new(Expression.new('x'),
        Expression.new(15,[EquationStep.new(:add,5,:right)]))
      arranged_equation = Equation.new(Expression.new('x'),
        Expression.new(20))
      expect(equation.solution_next_step).to eq arranged_equation
    end

    it 'returns 1st step of a one step right division equation' do
      equation = Equation.new(Expression.new('x',
        [EquationStep.new(:divide,5,:right)]),Expression.new(15))
      arranged_equation = Equation.new(Expression.new('x'),
        Expression.new(15,[EquationStep.new(:multiply,5,:right)]))
      expect(equation.solution_next_step).to eq arranged_equation
    end

    it 'returns 2nd step of a one step right division equation' do
      equation = Equation.new(Expression.new('x'),
        Expression.new(15,[EquationStep.new(:multiply,5,:right)]))
      arranged_equation = Equation.new(Expression.new('x'),
        Expression.new(75))
      expect(equation.solution_next_step).to eq arranged_equation
    end

    it 'returns 1st step of a one step left subtraction equation' do
      equation = Equation.new(Expression.new('x',
        [EquationStep.new(:subtract,15,:left)]),Expression.new(5))
      arranged_equation = Equation.new(Expression.new(5,
        [EquationStep.new(:subtract,15,:left)]),Expression.new('x'))
      expect(equation.solution_next_step).to eq arranged_equation
    end

    it 'returns 2st step of a one step left subtraction equation' do
      equation = Equation.new(Expression.new(5,
        [EquationStep.new(:subtract,15,:left)]),Expression.new('x'))
      arranged_equation = Equation.new(Expression.new(10),Expression.new('x'))
      expect(equation.solution_next_step).to eq arranged_equation
    end

    it 'returns 1st step of a one step left division equation' do
      equation = Equation.new(Expression.new('x',
        [EquationStep.new(:divide,15,:left)]),Expression.new(5))
      arranged_equation = Equation.new(Expression.new(5,
        [EquationStep.new(:divide,15,:left)]),Expression.new('x'))
      expect(equation.solution_next_step).to eq arranged_equation
    end

    it 'returns 2st step of a one step left division equation' do
      equation = Equation.new(Expression.new(5,
        [EquationStep.new(:divide,15,:left)]),Expression.new('x'))
      arranged_equation = Equation.new(Expression.new(3),Expression.new('x'))
      expect(equation.solution_next_step).to eq arranged_equation
    end
  end

  describe '#generate_solution' do
    it 'for one step right addition equation' do
      equation = Equation.new(Expression.new('x',
        [EquationStep.new(:add,5,:right)]),Expression.new(11))
      equation1 = Equation.new(Expression.new('x',
        [EquationStep.new(:add,5,:right)]),Expression.new(11))
      equation2 = Equation.new(Expression.new('x'),Expression.new(11,
          [EquationStep.new(:subtract,5,:right)]))
      equation3 = Equation.new(Expression.new('x'),Expression.new(6))
      expect(equation.generate_solution).to eq [equation1,equation2,equation3]
    end

    it 'for one step left division equation' do
      equation = Equation.new(Expression.new('x',
        [EquationStep.new(:divide,15,:left)]),Expression.new(5))
      equation1 = Equation.new(Expression.new('x',
        [EquationStep.new(:divide,15,:left)]),Expression.new(5))
      equation2 = Equation.new(Expression.new(5,[EquationStep.new(:divide,15,:left)]),
        Expression.new('x'),)
      equation3 = Equation.new(Expression.new(3),Expression.new('x'),)
      expect(equation.generate_solution).to eq [equation1,equation2,equation3]
    end

    it 'for two step linear equation with left subtraction' do
      equation = Equation.new(Expression.new('x',
        [EquationStep.new(:multiply,2,:right),EquationStep.new(:subtract,14,:left)]),
        Expression.new(4))
      equation1 = Equation.new(Expression.new('x',
        [EquationStep.new(:multiply,2,:right),EquationStep.new(:subtract,14,:left)]),
        Expression.new(4))
      equation2 = Equation.new(Expression.new(4,[EquationStep.new(:subtract,14,:left)]),
        Expression.new('x',[EquationStep.new(:multiply,2,:right)]))
      equation3 = Equation.new(Expression.new(10),
        Expression.new('x',[EquationStep.new(:multiply,2,:right)]))
      equation4 = Equation.new(Expression.new(10,[EquationStep.new(:multiply,2,:right)]),
        Expression.new('x'))
      equation5 = Equation.new(Expression.new(5),Expression.new('x'))
      expect(equation.generate_solution).to eq [equation1,equation2,equation3,equation4,equation5]
    end
  end

end
