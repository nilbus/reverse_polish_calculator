require 'spec_helper'

describe ReversePolishCalculator::Calculator do
  subject(:calculator) { described_class.new }

  describe '#calculate' do
    before :each do
      ReversePolishCalculator::MathEngine.stub(:process_tokens)
      ReversePolishCalculator::Operator.stub(:new)
    end

    it 'creates Operator objects for each operator' do
      calculator.calculate("  1  2.0\n3 + 4\n")
      ReversePolishCalculator::Operator.should_receive(:new).once
    end

    it 'sends the tokens in each line of input to MathEngine#process_tokens' do
      calculator.calculate("1 2\n3 4 +")
      ReversePolishCalculator::MathEngine.should_receive(:process_tokens).twice
    end

    it 'accepts both String and IO inputs' do
      calculator.calculate("1 2\n3 4 +")
      calculator.calculate(StringIO.new("1 2\n3 4 +"))
    end
  end
end
