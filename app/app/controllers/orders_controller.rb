class OrdersController < ApplicationController
  def new
  end
  
  def create
    render plain: params[:order].inspect
  end
  
end
