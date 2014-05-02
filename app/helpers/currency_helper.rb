module CurrencyHelper
  def to_sg_dollar x
    'S$ ' + ( to_real_amount x )
  end

  def to_real_amount x
    x = x.to_s
    number_with_precision( ( x.size < 3 ? x.prepend( '0' * (3 - x.size) ) : x ).insert(-3, '.').to_f, precision: 2)
  end
end