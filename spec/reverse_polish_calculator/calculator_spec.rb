require 'spec_helper'

describe ReversePolishCalculator::Calculator do
  subject(:calculator) { described_class.new }

  describe '#calculate' do
    before :each do
      ReversePolishCalculator::MathEngine.any_instance.stub(:process_tokens => nil, :stack => [])
      ReversePolishCalculator::Operator.stub(:new => stub(:+))
    end

    it 'creates Operator objects for each operator' do
      ReversePolishCalculator::Operator.should_receive(:new).once
      calculator.calculate("  1  2.0\n3 + 4\n")
    end

    it 'sends the tokens in each line of input to MathEngine#process_tokens' do
      ReversePolishCalculator::MathEngine.any_instance.should_receive(:process_tokens).twice
      calculator.calculate("1 2\n3 4 +")
    end

    it 'accepts both String and IO inputs' do
      calculator.calculate("1 2\n3 4 +")
      calculator.calculate(StringIO.new("1 2\n3 4 +"))
    end

    it 'yields the stack to the block for each line in the input' do
      expect { |block| calculator.calculate("1 2\n3 4 +", &block) }.to yield_successive_args([anything, nil], [anything, nil])
    end

    it 'yields errors to the block' do
      ReversePolishCalculator::Operator.stub(:new) { raise 'Exception!' }
      expect { |block| calculator.calculate("3 4 +", &block) }.to yield_with_args([anything, 'Exception!'])
    end
  end
end
