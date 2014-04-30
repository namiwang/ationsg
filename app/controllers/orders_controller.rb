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
    @order.user = current_user
    if @order.valid?
      @order.save
      redirect_to order_pay_path(@order)
    else
      flash[:alert] = @order.errors.full_messages
      render 'new'
    end
  end

  def index
    @orders = current_user.orders
  end

  def show
  end

  def pay
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
