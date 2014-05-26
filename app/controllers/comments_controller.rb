class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def create
    @product = Product.find params['product_id']
    @comment = @product.comments.create( comment_attributes )
    @comment.user = current_user
    if not @comment.valid?
      @comment.errors.full_messages.each do |m|
        (flash[:alert] ||= []) << m
      end
    else
      @comment.save!
    end
    redirect_to product_path @product
  end

  private

  def comment_attributes
    # params['comment'].permit(:comment, images_attributes: [:_destroy, :id, :attachment])
    # TODO _destroy and id
    params['comment'].permit(:comment, images_attributes: [:attachment])
  end
end
