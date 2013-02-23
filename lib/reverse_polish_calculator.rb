require "reverse_polish_calculator/version"
require "reverse_polish_calculator/operator"
require "reverse_polish_calculator/math_engine"
require "reverse_polish_calculator/calculator"

module ReversePolishCalculator
  def self.calculate(expression, &block)
    Calculator.new.calculate(expression, &block)
  end
end
