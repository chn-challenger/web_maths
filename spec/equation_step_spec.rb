require './generators/equation_step'

describe EquationStep do
  describe '#initialize/new' do
    context 'addition step' do
      shared_context 'addition step' do
        before(:all) do
          @step = EquationStep.new(:add,5,:right)
        end
      end

      include_context 'addition step'

      it 'has operation of addition' do
        expect(@step.operation).to eq :add
      end

      it 'has value for the step' do
        expect(@step.value).to eq 5
      end

      it 'has an orientation of left or right' do
        expect(@step.orientation).to eq :right
      end
    end

    context 'multiplication step' do
      shared_context 'multiplication step' do
        before(:all) do
          @step = EquationStep.new(:multiply,7,:left)
        end
      end

      include_context 'multiplication step'

      it 'has operation of addition' do
        expect(@step.operation).to eq :multiply
      end

      it 'has value for the step' do
        expect(@step.value).to eq 7
      end

      it 'has an orientation of left or right' do
        expect(@step.orientation).to eq :left
      end
    end
  end

  describe '#reverse' do
    it 'left subtraction is self reversing' do
      step = EquationStep.new(:subtract,5,:left)
      expect(step.reverse).to eq step
    end

    it 'left division is self reversing' do
      step = EquationStep.new(:divide,5,:left)
      expect(step.reverse).to eq step
    end

    it 'reverse of addition is right subtraction' do
      step = EquationStep.new(:add,5)
      expect(step.reverse).to eq EquationStep.new(:subtract,5,:right)
    end

    it 'reverse of multiplication is right division' do
      step = EquationStep.new(:multiply,5)
      expect(step.reverse).to eq EquationStep.new(:divide,5,:right)
    end

    it 'reverse of right subtraction is right addition' do
      step = EquationStep.new(:subtract,5,:right)
      expect(step.reverse).to eq EquationStep.new(:add,5,:right)
    end

    it 'reverse of right division is right multiplication' do
      step = EquationStep.new(:divide,5,:right)
      expect(step.reverse).to eq EquationStep.new(:multiply,5,:right)
    end
  end
end
