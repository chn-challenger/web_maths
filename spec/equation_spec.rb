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
