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

