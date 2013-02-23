# Operator performs calculations on operands
class ReversePolishCalculator::Operator
  def initialize(token)
    @value = token
    raise ArgumentError.new("Invalid operator: #{token.inspect}") unless valid_operator?
  end

  # The number of operands for this operator.
  # Optional arguments to methods are required to prevent ambiguity.
  #
  def arity
    float = 1.2
    method_arity = float.method(@value).arity
    arity_with_optional_arguments = method_arity.abs
    operator_arity = arity_with_optional_arguments + 1

    operator_arity
  end

  def operate(*operands)
    raise ArgumentError.new("Not enough operands #{operands.inspect} to perform #{@value.inspect}") unless operands.size == arity
    raise ZeroDivisionError.new("Cannot divide #{operands.first} by 0") if @value == '/' && operands.last == 0
    operands = operands.map { |operand| operand.to_f }
    result = operands.shift.send(@value, *operands)

    result
  end

private

  # Valid operators are methods that Float responds to that return numbers
  def valid_operator?
    float = 1.2
    method = float.method(@value)
    arguments = [3.4] * (arity - 1)
    result = method.call(*arguments)

    result.is_a? Numeric
  rescue NameError
    false
  end
end
