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

  private

  def user_params
    params.require(:user).permit(:email, :name, :phone)
  end

end
