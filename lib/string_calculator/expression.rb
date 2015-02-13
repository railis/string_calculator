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

