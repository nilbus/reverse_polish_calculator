require 'spec_helper'

describe ReversePolishCalculator do
  it 'delegates to a Calculator instance to do the work' do
    ReversePolishCalculator::Calculator.any_instance.should_receive(:calculate)
    described_class.calculate('')
  end

  it 'should have a version number' do
    ReversePolishCalculator::VERSION.should_not be_nil
  end
end
