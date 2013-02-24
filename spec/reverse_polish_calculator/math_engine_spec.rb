require 'spec_helper'

describe ReversePolishCalculator::MathEngine do
  subject(:math_engine) { described_class.new }
  let(:numeric_tokens) { [1.1, 2.2, 3.3] }
  let(:plus_operator) do
    plus_operator = stub(:+).tap do |operator|
      operator.stub(:arity => 2, :operate => :result)
    end
  end

  its(:stack) { should respond_to :each }
  its(:stack) { should respond_to :last }

  describe '#process_tokens' do
    it 'pushes numeric tokens onto the stack' do
      math_engine.process_tokens numeric_tokens
      math_engine.stack.should == numeric_tokens
    end

    it 'operates on Operator tokens with the number of Numeric tokens equal to the operator arity' do
      plus_operator.should_receive(:operate)
      math_engine.process_tokens(numeric_tokens << plus_operator)
      math_engine.stack.size.should == 2
      math_engine.stack.last.should == :result
    end

    it "doesn't modify the stack when there are too few operands" do
      plus_operator.stub(:operate) { raise ArgumentError }
      expect { math_engine.process_tokens([9, plus_operator]) }.to raise_error ArgumentError
      math_engine.stack.should == [9]
    end
  end
end
