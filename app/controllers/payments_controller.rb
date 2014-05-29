class PaymentsController < ApplicationController
  before_action :authenticate_user!
  before_action :get_order, only: [:create]
  before_action :chk_order_ownership, only: [:create]

  def create

    # TODO check payment self
    # TODO check payment state
    # TODO check order state
    # TODO check if may create new payment
    # redirect_to root_path if not @order.may_create_new_payment?

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

      # new_payment = @order.payments.build({method: 'paypal', detail: paypal_params.to_json})
      new_payment = @order.payments.last
      new_payment.update({method: 'paypal', detail: paypal_params.to_json})
      if new_payment.valid?
        new_payment.pay # state machine
        new_payment.save!

        paypal_url = ENV['PAYPAL_URL'] + paypal_params.to_query
        redirect_to paypal_url
      else
        redirect_to root_path
      end
    else
      # invalid payment method
      redirect_to root_path
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
