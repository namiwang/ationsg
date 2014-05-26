class ProductsController < ApplicationController
  before_action :get_product
  before_action :authenticate_user!, only: [:like, :unlike]

  def show
    @comments = @product.comments
    # TODO dont load all comments at first, pagination maybe

    if user_signed_in?
      @current_user_comments = @product.comments.where(user: current_user)
    end
    @new_comment = @product.comments.new
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
