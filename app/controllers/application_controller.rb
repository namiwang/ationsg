class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :get_cart_items

  private

  def get_cart_items
    begin
      @cart = {items: (JSON.parse cookies[:cart_items])}
    rescue
      @cart = {items: []}
    ensure
      @cart[:size] = @cart[:items].size
      # TODO @cart[:total_price] = 0
    end
  end

  # TODO, validate cart, say no negative item amount
end
