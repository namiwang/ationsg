class CartController < ApplicationController
  before_action :authenticate_user!, only: [:show]

  def show
  end

  def partial
    render partial: 'navbar_partial', locals: { cart: @cart }, layout: false
  end
end
