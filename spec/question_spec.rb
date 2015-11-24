require './generators/question'

describe Questions do

  describe '#fraction_question' do
    context 'it can generates random fraction addition questions' do
      shared_context 'example addition question' do
        before(:all) do
          srand(100)
          dummy_class = Class.new{include Questions}.new
          @question = dummy_class.fraction_question
        end
      end

      include_context 'example addition question'

      it 'has operator of addition' do
        expect(@question[:operator]).to eq 'addition'
      end

      it 'generates a fraction for the addition' do
        expect(@question[:fraction1]).to eq Fraction.new(8,2,5)
      end

      it 'generates another fraction for the addition' do
        expect(@question[:fraction2]).to eq Fraction.new(7,8,9)
      end

      it 'generates solution to the question' do
        expect(@question[:solution]).to eq Fraction.new(16,13,45)
      end
    end
  end
end
