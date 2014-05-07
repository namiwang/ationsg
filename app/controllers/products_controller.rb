class ProductsController < ApplicationController
  before_action :get_product
  before_action :authenticate_user!, only: [:like, :unlike]

  def show
  end

  def like
    current_user.likes @product unless current_user.liked? @product
    render nothing: true
  end

  def unlike
    current_user.unlike @product if current_user.liked? @product
    render nothing: true
  end

  private

  def get_product
    @product = Product.find ( params[:id] || params[:product_id] )
  end
end
