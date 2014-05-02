class SubscriptionsController < ApplicationController
  
  def index
    @subscriptions = Subscription.all
    @quintly_subs = Subscription.quintly
  end
  
  def show 
    @subscription = Subscription.find(params[:id])
    # Sidekiq::Cron::Job.create( 
      # name: @subscription.email+'_'+@subscription.vendor+'Worker_'+@subscription.id.to_s, 
      # cron: @subscription.cron, 
      # klass: @subscription.vendor+'Worker',
      # args: [@subscription.id]
    # )
  end
  
  def new
    @subscription = Subscription.new
  end
  
  def create
    @subscription = Subscription.new(subscription_params)
    if @subscription.save #if subscription input validated 
       if @subscription.vendor == 'Quintly'
          @subscription.create_quintly_worker(cron: @subscription.cron)
       end
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
