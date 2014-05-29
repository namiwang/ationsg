class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :get_order, only: [:show, :pay]
  before_action :chk_order_ownership, only: [:show, :pay]

  def new
    @order = Order.new
    @order.build_transport
  end

  def create
    @order = Order.new order_params
    # user
    @order.user = current_user
    # transport
    # payment
    @order.payments.build(order: @order)
    # cart
    @order.cart = @cart.save_to_order_version

    if not @order.valid?
      flash[:alert] = @order.errors.full_messages
      render 'new'
    else
      @order.save!
      # TODO
      # 2. order.transport.state -> created
      cart_clear
      redirect_to pay_order_path(id: @order.id)
    end
  end

  def pay
    # TODO check order payment state
  end

  def index
    @orders = current_user.orders
  end

  # TODO should use orders#show to render order card
  # def show
  # end

  private

  def order_params
    params.require(:order).permit(transport_attributes: [:recipient_name, :recipient_phone, :recipient_address])
  end

  def get_order
    redirect_to root_path unless Order.exists? params[:id]
    @order = Order.find params[:id]
  end

  def chk_order_ownership
    redirect_to root_path unless @order.user == current_user 
  end
end
