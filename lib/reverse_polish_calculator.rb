require "reverse_polish_calculator/version"
require "reverse_polish_calculator/operator"
require "reverse_polish_calculator/math_engine"
require "reverse_polish_calculator/calculator"

module ReversePolishCalculator
  def self.calculate(expression, options = {}, &block)
    Calculator.new.calculate(expression, options, &block)
  end
end
