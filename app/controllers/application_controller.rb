class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include CartModule

  before_action :cart_init
  before_action :set_locale
 
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

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options(options={})
    { locale: I18n.locale }
  end

end
