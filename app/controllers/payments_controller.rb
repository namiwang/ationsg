class PaymentsController < ApplicationController
  before_action :authenticate_user!
  before_action :get_order, only: [:create]
  before_action :chk_order_ownership, only: [:create]

  def create
    # TODO check payment self
    # TODO check payment state
    # TODO check order state
    # TODO check if may create new payment
    @order.build_payment(order: @order) if @order.payment.nil?
    new_payment = @order.payment
    return redirect_to root_path unless new_payment.may_pay?

    case params[:method]
    when 'paypal'
      paypal_params = {
        business: ENV['PAYPAL_ACCOUNT'],
        cmd: '_cart',
        upload: 1,
        currency_code: 'SGD',
        :return => url_for(controller: 'my', action: 'orders'),
        :invoice => "ORDER#{@order.id}PAYMENT"#TODO payment id? but payment may be empty
      }
      @order.cart[:items].each_with_index do |item ,index|
        item_params_to_merge = {}
        case item[:type]
        when 'product'
          item_params_to_merge = {
            "amount_#{index + 1}" => view_context.to_real_amount(item[:price]),# TODO convert to real number
            "item_name_#{index + 1}" => item[:product].name,
          }
        end
        paypal_params.merge! item_params_to_merge
      end

      new_payment.update({method: 'paypal', detail: paypal_params.to_json})
      return redirect_to root_path unless new_payment.valid?
      new_payment.pay! # state machine

      paypal_url = ENV['PAYPAL_URL'] + paypal_params.to_query
      return redirect_to paypal_url
    when 'card'
      new_payment.update({method: 'card'})

      return redirect_to root_path unless new_payment.valid?

      # chk if enough card balance
      if not current_user.card_balance >= @order.total_price
        (flash[:alert] ||= []) << (I18n.t 'payments.not_sufficient_funds')
        return redirect_to pay_order_path(@order)
      end

      return redirect_to root_path unless current_user.cards.first.pay @order.total_price
      new_payment.receive! # state machine
      (flash[:notice] ||= []) << (I18n.t 'payments.success')
      return redirect_to my_orders_path
    else
      # invalid payment method
      return redirect_to root_path
    end
  end

  private

  def order_params
    params.require(:order).permit(transport_attributes: [:recipient_name, :recipient_phone, :recipient_address])
  end

  def get_order
    redirect_to root_path unless Order.exists? params[:order_id]
    @order = Order.find params[:order_id]
  end

  def chk_order_ownership
    redirect_to root_path unless @order.user == current_user 
  end
end
