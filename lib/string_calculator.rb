require_relative "string_calculator/expression"
require_relative "string_calculator/expression_parser"
require_relative "string_calculator/simple_expression_evaluator"
require_relative "string_calculator/evaluator"

class StringCalculator
  attr_reader :exp

  def initialize(exp)
    @exp = ExpressionParser.new(exp).parse
  end

  def calculate
    Evaluator.new(exp).evaluate
  end
end
