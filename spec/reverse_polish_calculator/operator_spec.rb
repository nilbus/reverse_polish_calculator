require 'spec_helper'

describe ReversePolishCalculator::Operator do
  subject { described_class.new('+') }

  describe '#new' do
    it 'raises an ArgumentError if passed an invalid operator' do
      expect { described_class.new('bad') }.to raise_error ArgumentError
      expect { described_class.new(:nan?) }.to raise_error ArgumentError
    end
  end

  describe '#arity' do
    it 'returns the number of operands needed for the operation' do
      described_class.new('+').arity.should == 2
      described_class.new(:abs).arity.should == 1
    end

    it 'avoids ambiguity by requiring optional arguments to be passed' do
      described_class.new(:round).arity.should == 2
    end
  end

  describe '#operate' do
    it 'performs the operation with the given operands, and returns the numeric result' do
      described_class.new(:+).operate(1, 2).should == 3
      described_class.new(:-).operate(1, 2).should == -1
      described_class.new(:/).operate(1, 2).should == 0.5
      described_class.new(:round).operate(5.5, 0.0).should == 6.0
      described_class.new(:abs).operate(-5.5).should == 5.5
    end

    it 'raises an ArgumentError if passed the wrong number of operands' do
      expect { described_class.new('+').operate }.to raise_error ArgumentError
      expect { described_class.new('+').operate(1) }.to raise_error ArgumentError
      expect { described_class.new('+').operate(1, 2, 3) }.to raise_error ArgumentError
    end

    it 'raises an ZeroDivisionError when dividing by 0' do
      expect { described_class.new('/').operate(1.0, 0.0) }.to raise_error ZeroDivisionError
    end
  end
end
