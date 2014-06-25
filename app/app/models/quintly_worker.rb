class QuintlyWorker < ActiveRecord::Base
  belongs_to :subscription
  
  validates :quintly_metric, presence: true
  validates :quintly_period, presence: true
  validates :quintly_interval, presence: true
  
  include Sidekiq::Worker  

  def perform(id, metric, period, interval, profileids)
    puts '****************** RUNNING QUINTLY TASK NUMBER '+id.to_s
    endTime = Date.today.to_s
    startTime = period.days.ago.to_date.to_s
    puts '***** METRIC: '+ metric
    puts '***** STARTTIME: '+ startTime
    puts '***** ENDTIME: '+ endTime
    puts '***** INTERVAL: '+ interval
    puts '***** PROFILEIDS: '+ profileids
    
    # Quintly clientID & secret
    @auth = {:username => 'ENV["QUINTLY_USERNAME"]', :password => 'ENV["QUINTLY_PASSWORD"]'}
    
    response = HTTParty.get('https://api.quintly.com/v0.9/qql?metric='+metric+'&startTime='+startTime+'&endTime='+endTime+'&interval='+interval.downcase+'&profileIds='+profileids, {:basic_auth => @auth})

    puts response.code, response.message, response.headers.inspect
    #csv = response.body
    json = JSON.parse(response.body)['data']
    #puts json.to_s
    json.first.collect {|k,v| k}.join(',')
    csv = json.collect {|node| "#{node.collect{|k,v| v}.join(',')}\n"}.join
    
    ScheduledMailer.sendcsvemail(csv).deliver
      
  end
end