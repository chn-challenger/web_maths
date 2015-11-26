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
    it 'can generate random one step addition question' do
      srand(120)
      question = LinearEquation.generate_one_sided()
      expect(question.left_side).to eq []
      expect(question.right_side).to eq 6
      expect(question.solution)to eq 5
    end

    it 'can generate random one step addition question with options' do
      srand(130)
      options = {addition_range:50}
      question = LinearEquation.generate_one_sided(1,options)
    end

  end
end
