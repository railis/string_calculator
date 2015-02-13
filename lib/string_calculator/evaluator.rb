class Evaluator
  attr_reader :exp

  def initialize(exp)
    @exp = exp
  end

  def evaluate
    until Expression.new(exp).is_simple_expression?
      simple_expressions = Expression.new(exp).get_simple_expressions
      simple_expressions.each do |simple_expression|
        exp.gsub!(simple_expression, SimpleExpressionEvaluator.new(simple_expression).evaluate.to_s)
      end
      if Expression.new(exp).with_incorrect_parity?
        raise "Incorrect expression" and return
      end
    end
    SimpleExpressionEvaluator.new(exp).evaluate
  end
end

