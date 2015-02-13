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

