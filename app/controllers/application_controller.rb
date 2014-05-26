class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include CartModule

  before_action :cart_init

  def cart_init
    @cart = Cart.new.initialize_from_cookie cookies[:cart_items]
    cart_save_to_cookie
  end

  def cart_save_to_cookie
    cookies[:cart_items] = @cart.cookie_version
  end

  def cart_clear
    @cart.clear
    cart_save_to_cookie
  end
end
