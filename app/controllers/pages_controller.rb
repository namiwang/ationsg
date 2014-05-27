class PagesController < ApplicationController
  def show
    case params[:id]
    when 'home'
      render 'home'
    else
      @page = Page.find_by(name: params[:id])
    end
  end
end
