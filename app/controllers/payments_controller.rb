class PaymentsController < ApplicationController
  before_action :authenticate_user!
  before_action :get_order, only: [:new, :create]
  before_action :chk_order_ownership, only: [:new, :create]

  def new
    case params[:method]
    when 'paypal'
      binding.pry
      paypal_params = {
        business: ENV['PAYPAL_ACCOUNT'],
        cmd: '_cart',
        upload: 1,
        currency_code: 'SGD',
        :return => 'TODO',
        :invoice => "ORDER#{@order.id}PAYMENT"#TODO payment id? but payment may be empty
      }
      @order.cart[:items].each_with_index do |item ,index|
        item_params_to_merge = {}
        case item[:type]
        when 'product'
          item_params_to_merge = {
            "amount_#{index + 1}" => item[:price],# TODO convert to real number
            "item_name_#{index + 1}" => item[:product].name,
          }
        end
        paypal_params.merge! item_params_to_merge
      end
      paypal_url = ENV['PAYPAL_URL'] + paypal_params.to_query
      redirect_to paypal_url
    else
      redirect_to root_path
    end
  end

  def create
    # check order self
    # check order state
    # check payment self
    # check payment state
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
