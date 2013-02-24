module ReversePolishCalculator
  # MathEngine maintains a stack and processes tokens in RPN calculations
  class MathEngine
    def initialize
      @stack = []
    end

    def stack
      @stack.dup
    end

    def process_tokens(tokens)
      tokens.each do |token|
        if token.is_a? Numeric
          @stack << token
          next
        end
        operator = token
        operands = @stack.pop(token.arity)
        result = operator.operate(*operands)
        @stack.push(result)
      end
    end
  end
end
