class MyController < ApplicationController
  before_action :authenticate_user!

  layout 'my'

  def info
  end

  def orders
    @orders = current_user.orders    
  end
end
