class ExpressionParser
  attr_reader :exp

  def initialize(exp)
    @exp = exp
  end

  def parse
    if data_correct? and Expression.new(exp).is_closed? and !Expression.new(exp).has_negative_numbers?
      stripped_expression
    else
      raise "Incorect input"
    end
  end
  
  def stripped_expression
    exp.gsub("\s", "")
  end

  def data_correct?
    exp.class == String and exp.size > 0
  end
end

class SimpleExpressionEvaluator
  attr_reader :exp

  def initialize(exp)
    @exp = exp.gsub("+-", "-")
  end

  def evaluate
    if operator == "+"
      left.to_i + right.to_i
    elsif operator == "-"
      left.to_i - right.to_i
    end
  end

  private

  def left
    number = get_inside.scan(/\d+/).first
    if get_inside[0] == "-"
      "-" + number
    else
      number
    end
  end

  def right
    get_inside.scan(/\d+/).last
  end

  def operator
    get_inside.scan(/[\+|\-]/).first
  end

  def get_inside
    exp.slice(1..-2)
  end
end

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

class Expression
  attr_reader :exp

  SIMPLE_EXP_REGEX = /\([\+|\-]{0,1}\d+[\+|\-][\+|\-]{0,1}\d+\)/

  def initialize(exp)
    @exp = exp
  end

  def is_simple_expression?
    (exp =~ SIMPLE_EXP_REGEX) == 0
  end

  def is_closed?
    exp[0] == "(" and exp[-1] == ")"
  end

  def with_incorrect_parity?
    exp.scan(/[\(|\)]/).size == 2 and exp.scan(/\d+/).size > 2
  end

  def has_negative_numbers?
    exp.scan(/\-\d+/).size > 0
  end

  def get_simple_expressions
    exp.scan(SIMPLE_EXP_REGEX)
  end

  def get_inside
    exp.slice("1..-2")
  end
end

class StringCalculator
  attr_reader :exp

  def initialize(exp)
    @exp = ExpressionParser.new(exp).parse
  end

  def calculate
    Evaluator.new(exp).evaluate
  end
end
