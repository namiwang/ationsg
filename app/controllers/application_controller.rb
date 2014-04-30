class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include CartModule

  before_action :cart_init
  before_action :empty_flash

  def cart_init
    @cart = Cart.new
    @cart.initialize_from_cookie cookies[:cart_items]
    @cart.reset unless @cart.valid?
    cookies[:cart_items] = @cart.items.to_json
    @cart.parse_to_model
  end

  def empty_flash
    flash = {}
  end
end
