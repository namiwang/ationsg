module CurrencyHelper
  def to_sg_dollar x
    number_to_currency x, unit: 'S$'
  end

  def to_decimal x
    x + '.00'
  end
end