require './generators/question'

describe Questions do
  describe '#random_fraction' do
    shared_context 'a random fraction' do
      before(:all) do
        srand(100)
        dummy_class = Class.new{include Questions}.new
        @fraction = dummy_class.random_fraction
      end
    end

    include_context 'a random fraction'

    it 'has a random integer part' do
      expect(@fraction.integer).to eq 8
    end

    it 'has a random numerator' do
      expect(@fraction.numerator).to eq 2
    end

    it 'has a random denominator' do
      expect(@fraction.denominator).to eq 5
    end

    it 'has is a proper fraction' do
      expect(@fraction.numerator < @fraction.denominator).to be true
    end
  end

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

    context 'it can generates random fraction subtraction questions' do
      shared_context 'example subtraction question' do
        before(:all) do
          srand(200)
          dummy_class = Class.new{include Questions}.new
          @question = dummy_class.fraction_question('subtract')
        end
      end

      include_context 'example subtraction question'

      it 'has operator of subtraction' do
        expect(@question[:operator]).to eq 'subtract'
      end

      it 'generates a fraction for the subtraction' do
        expect(@question[:fraction1]).to eq Fraction.new(10,1,2)
      end

      it 'generates another fraction for the subtraction' do
        expect(@question[:fraction2]).to eq Fraction.new(4,5,9)
      end

      it 'generates solution to the question' do
        expect(@question[:solution]).to eq Fraction.new(5,17,18)
      end
    end
    
    # context 'it can generates random fraction addition questions' do
    #   shared_context 'example addition question' do
    #     before(:all) do
    #       srand(100)
    #       dummy_class = Class.new{include Questions}.new
    #       @question = dummy_class.fraction_question
    #     end
    #   end
    #
    #   include_context 'example addition question'
    #
    #   it 'has operator of addition' do
    #     expect(@question[:operator]).to eq 'addition'
    #   end
    #
    #   it 'generates a fraction for the addition' do
    #     expect(@question[:fraction1]).to eq Fraction.new(8,2,5)
    #   end
    #
    #   it 'generates another fraction for the addition' do
    #     expect(@question[:fraction2]).to eq Fraction.new(7,8,9)
    #   end
    #
    #   it 'generates solution to the question' do
    #     expect(@question[:solution]).to eq Fraction.new(16,13,45)
    #   end
    # end
    #
    # context 'it can generates random fraction addition questions' do
    #   shared_context 'example addition question' do
    #     before(:all) do
    #       srand(100)
    #       dummy_class = Class.new{include Questions}.new
    #       @question = dummy_class.fraction_question
    #     end
    #   end
    #
    #   include_context 'example addition question'
    #
    #   it 'has operator of addition' do
    #     expect(@question[:operator]).to eq 'addition'
    #   end
    #
    #   it 'generates a fraction for the addition' do
    #     expect(@question[:fraction1]).to eq Fraction.new(8,2,5)
    #   end
    #
    #   it 'generates another fraction for the addition' do
    #     expect(@question[:fraction2]).to eq Fraction.new(7,8,9)
    #   end
    #
    #   it 'generates solution to the question' do
    #     expect(@question[:solution]).to eq Fraction.new(16,13,45)
    #   end
    # end
  end
end
