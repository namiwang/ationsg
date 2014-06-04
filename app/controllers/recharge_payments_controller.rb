class RechargePaymentsController < ApplicationController
  before_action :authenticate_user!

  def new
    @card = Card.find params[:card_id]
    chk_ownership
    @recharge_payment = RechargePayment.new
  end

  def create
    @card = Card.find params[:recharge_payment][:card_id]
    chk_ownership
    new_recharge_payment = RechargePayment.new(recharge_payment_params)
    new_recharge_payment.update( card: @card, user: current_user )
    (return redirect_to root_path) unless new_recharge_payment.save
    # pay
    case new_recharge_payment.pay_method
    when 'paypal'
      paypal_params = {
        business: ENV['PAYPAL_ACCOUNT'],
        cmd: '_cart',
        upload: 1,
        currency_code: 'SGD',
        :return => url_for(controller: 'my', action: 'cards'),
        :invoice => "RECHARGE_PAYMENT#{new_recharge_payment.id}",
        amount_1: view_context.to_real_amount(new_recharge_payment.amount),
        item_name_1: 'RECHARGE'
      }

      new_recharge_payment.pay! # state machine

      paypal_url = ENV['PAYPAL_URL'] + paypal_params.to_query
      return redirect_to paypal_url
    else
      return redirect_to root_path
    end
  end

  private

  def chk_ownership
    redirect_to root_path unless @card.user == current_user
  end

  def recharge_payment_params
    params[:recharge_payment][:amount] += '00'
    params.require(:recharge_payment).permit(:amount, :pay_method)
  end
end