class SubscriptionsController < ApplicationController
  
  def index
    @subscriptions = Subscription.all
  end
  
  def show 
    @subscription = Subscription.find(params[:id])
  end
  
  def new
    @subscription = Subscription.new
  end
  
  def create
    @subscription = Subscription.new(subscription_params)
    if @subscription.save #if subscription input validated
      @subscription.save
    else
      render 'new'
    end
  end
  
  def edit 
    @subscription = Subscription.find(params[:id])
  end
  
  def update
    @subscription = Subscription.find(params[:id])
    if @subscription.update(subscription_params)
      redirect_to @subscription
    else
      render 'edit'
    end  
  end
  
  private
    def subscription_params
      params.require(:subscription).permit(:email)
    end
  
end
