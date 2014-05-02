class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :get_order, only: [:show, :pay]
  before_action :self_order?, only: [:show, :pay]

  def new
    @order = Order.new
    @order.build_transport
  end

  def create
    @order = Order.new order_params
    # user
    @order.user = current_user
    # transport
    # cart
    @order.cart = @cart.save_to_order_version

    if not @order.valid?
      flash[:alert] = @order.errors.full_messages
      render 'new'
    end

    @order.save!
    @order.create
    # TODO
    # 2. order.transport.state -> created
    cart_clear
    redirect_to order_pay_path(@order)
  end

  def index
    @orders = current_user.orders
  end

  def show
  end

  def pay
    # TODO, check order state

    render 
  end

  private

  def order_params
    params.require(:order).permit(transport_attributes: [:recipient_name, :recipient_phone, :recipient_address])
  end

  def get_order
    begin
      @order = Order.find(params[:id] || params[:order_id])
    rescue
      redirect_to root_path
    end
  end

  def self_order?
    @order.user == current_user 
  end
end
