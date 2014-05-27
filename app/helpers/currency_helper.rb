module CurrencyHelper
  def to_sg_dollar(x)
    x = x.to_s
    'S$ ' + ( to_real_amount x.clone )
    # TODO figure out why x got changed without x.clone
  end

  def to_real_amount(x)
    number_with_precision( ( x.size < 3 ? x.prepend( '0' * (3 - x.size) ) : x ).insert(-3, '.').to_f, precision: 2)
  end
end