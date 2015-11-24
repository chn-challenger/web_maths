require './generators/question'

describe Questions do
  describe '#fraction_question' do
    context 'it can generates random fraction addition questions' do
      before(:all) do
        dummy_class = Class.new{include Questions}.new
        @question = dummy_class.fraction_question
      end

      it 'has operator of addition' do
        expect(@question[:operator]).to eq 'addition'
      end

      it 'generates a fraction for the addition' do
        fraction1 = Fraction.new(1,2,3)
        expect(@question[:fraction1]).to eq fraction1
      end

      it 'generates another fraction for the addition' do
        fraction2 = Fraction.new(2,4,5)
        expect(@question[:fraction2]).to eq fraction2
      end

      it 'generates solution to the question' do
        solution = Fraction.new(4,7,15)
        expect(@question[:solution]).to eq solution
      end
    end
  end
end
