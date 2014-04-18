class CartController < ApplicationController
  before_action :get_cart_items, only: [:show, :partial]
  before_action :authenticate_user!, only: [:show]

  def show
  end

  def partial
    render partial: 'partial', locals: { items: @cart_items }, layout: false
  end

  private

  def get_cart_items
    @cart_items = JSON.parse cookies[:cart_items]
  end
end
