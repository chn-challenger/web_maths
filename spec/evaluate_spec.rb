require './generators/evaluate'

describe Evaluate do

  let(:dummy_class){(Class.new{include Evaluate}).new}
  let(:left_add){double(:left_add,value:5,operation: :add,orientation: :left)}
  let(:right_add){double(:right_add,value:5,operation: :add,orientation: :right)}
  let(:left_subtract){double(:left_subtract,value:25,operation: :subtract,orientation: :left)}
  let(:right_subtract){double(:right_subtract,value:12,operation: :subtract,orientation: :right)}
  let(:left_multiply){double(:left_multiply,value:3,operation: :multiply,orientation: :left)}
  let(:right_multiply){double(:right_multiply,value:3,operation: :multiply,orientation: :right)}
  let(:left_divide){double(:left_divide,value:18,operation: :divide,orientation: :left)}
  let(:right_divide){double(:right_divide,value:2,operation: :divide,orientation: :right)}

  describe '#evaluate' do
    it 'can evaluate a letf addition' do
      expect(dummy_class.evaluate(11,[left_add])).to eq 16
    end

    it 'can evaluate a right addition' do
      expect(dummy_class.evaluate(11,[right_add])).to eq 16
    end

    it 'can evaluate a left subtraction' do
      expect(dummy_class.evaluate(11,[left_subtract])).to eq 14
    end

    it 'can evaluate a right subtraction' do
      expect(dummy_class.evaluate(22,[right_subtract])).to eq 10
    end

    it 'can evaluate a left multiplication' do
      expect(dummy_class.evaluate(11,[left_multiply])).to eq 33
    end

    it 'can evaluate a right multiplication' do
      expect(dummy_class.evaluate(11,[right_multiply])).to eq 33
    end

    it 'can evaluate a left division' do
      expect(dummy_class.evaluate(3,[left_divide])).to eq 6
    end

    it 'can evaluate a right division' do
      expect(dummy_class.evaluate(12,[right_divide])).to eq 6
    end

    it 'can evaluate multi-step expression' do
      expect(dummy_class.evaluate(5,[right_add,right_multiply,left_subtract])).to eq -5
    end
  end

end
