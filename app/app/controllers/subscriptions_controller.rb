class SubscriptionsController < ApplicationController
  
  def index
    @subscriptions = Subscription.all
    @quintly_subs = Subscription.quintly
  end
  
  def show 
    QuintlyWorker.perform_async('TESTA',2)
    @subscription = Subscription.find(params[:id])
  end
  
  def new
    @subscription = Subscription.new
  end
  
  def create
    @subscription = Subscription.new(subscription_params)
    if @subscription.save #if subscription input validated 
      redirect_to @subscription
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
  
  def destroy
    @subscription = Subscription.find(params[:id])
    @subscription.destroy
    redirect_to subscriptions_path
  end
  
  private
    def subscription_params
      params.require(:subscription).permit(:email, :vendor, :frequency, :cron)
    end
  
end
