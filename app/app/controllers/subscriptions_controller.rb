class SubscriptionsController < ApplicationController
  def new
  end
  
  def create
    @subscription = Subscription.new(subscription_params)
    @subscription.save
    redirect_to @subscription
  end
  
  private
    def subscription_params
      params.require(:subscription).permit(:email)
    end
  
end
