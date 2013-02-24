module ReversePolishCalculator
  # Calculator parses expressions from input and calculates the result using MathEngine
  class Calculator
    def initialize
      @math_engine = MathEngine.new
    end

    def calculate(input, options = {}, &block)
      input = StringIO.new(input) unless input.respond_to? :readline
      while expression = line_from(input)
        break if expression.strip == options[:exit_expression]
        begin
          tokens = tokenize(expression)
          @math_engine.process_tokens(tokens)
          yield [@math_engine.stack, nil] if block_given?
        rescue
          yield [@math_engine.stack, $!.message] if block_given?
        end
      end
    end

    def tokenize(expression)
      expression.split.map do |token|
        numeric = Float(token) rescue false

        if numeric
          Float(token)
        else
          Operator.new(token)
        end
      end
    end

  private

    def line_from(io)
      io.readline
    rescue EOFError
      nil
    end
  end
end
