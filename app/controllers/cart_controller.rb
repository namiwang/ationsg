class CartController < ApplicationController
  before_action :get_cart_items, only: [:show, :partial]
  before_action :authenticate_user!, only: [:show]

  def show
  end

  def partial
    render partial: 'partial', locals: { items: @cart[:items] }, layout: false
  end
end
