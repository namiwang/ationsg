class MyController < ApplicationController
  before_action :authenticate_user!

  layout 'my'

  def info
    @user = current_user
  end

  def info_update
    @user = current_user
    begin
      @user.update!(user_params)
    rescue
      @user.errors.full_messages.each do |m|
        (flash[:alert] ||= []) << m
      end
    else
      flash[:notice] = I18n.t 'devise.registrations.updated'
    end
    redirect_to my_info_path
  end

  def orders
    @orders = current_user.orders    
  end

  def liked
    # TODO now only include liked products
    @liked_products = current_user.get_up_voted Product
  end

  def comments
    @comments = Product.find_comments_by_user current_user
  end

  private

  def user_params
    params.require(:user).permit(:email, :name, :phone)
  end

end
