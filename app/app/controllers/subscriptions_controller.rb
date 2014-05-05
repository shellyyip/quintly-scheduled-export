class SubscriptionsController < ApplicationController
  
  def index
    @subscriptions = Subscription.all
    @quintly_subs = Subscription.quintly
  end
  
  def show 
    @subscription = Subscription.find(params[:id])
  end
  
  def new
    @subscription = Subscription.new
    @subscription.build_quintly_worker
  end

  def create
    @subscription = Subscription.new(subscription_params)
    if @subscription.vendor == 'Quintly'
      @subscription.build_quintly_worker(attributes = {
        quintly_metric: @subscription.quintly_worker.quintly_metric,
        quintly_period: @subscription.quintly_worker.quintly_period,
        quintly_interval: @subscription.quintly_worker.quintly_interval,
        quintly_profileids: @subscription.quintly_worker.quintly_profileids
      })
    end
    if @subscription.save #if subscription input validated
      Sidekiq::Cron::Job.create( 
        name: @subscription.email+'_'+@subscription.vendor+'Worker_'+@subscription.id.to_s, 
        cron: @subscription.cron, 
        klass: @subscription.vendor+'Worker',
        args: [@subscription.id, @subscription.quintly_worker.quintly_metric, @subscription.quintly_worker.quintly_period, @subscription.quintly_worker.quintly_interval, @subscription.quintly_worker.quintly_profileids]
    )
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
      Sidekiq::Cron::Job.destroy @subscription.email+'_'+@subscription.vendor+'Worker_'+@subscription.id.to_s
      Sidekiq::Cron::Job.create( 
        name: @subscription.email+'_'+@subscription.vendor+'Worker_'+@subscription.id.to_s, 
        cron: @subscription.cron, 
        klass: @subscription.vendor+'Worker',
        args: [@subscription.id, @subscription.quintly_worker.quintly_metric, @subscription.quintly_worker.quintly_period, @subscription.quintly_worker.quintly_interval, @subscription.quintly_worker.quintly_profileids]
    )
      redirect_to @subscription
    else
      render 'edit'
    end  
  end
  
  def destroy
    @subscription = Subscription.find(params[:id])
    @subscription.destroy
    Sidekiq::Cron::Job.destroy @subscription.email+'_'+@subscription.vendor+'Worker_'+@subscription.id.to_s
    redirect_to subscriptions_path
  end
  
  private
    def subscription_params
      params.require(:subscription).permit(:email, :vendor, :cron, 
        quintly_worker_attributes: [:quintly_metric, :quintly_period, :quintly_interval, :quintly_profileids]
      )
    end
  
end
