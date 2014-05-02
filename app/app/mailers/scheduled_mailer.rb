class ScheduledMailer < ActionMailer::Base
  default from: "from@example.com"
  
  def sendmail
    scheduler = Rufus::Scheduler.new
    # scheduler.every('1s') do
      # puts 'boop boop'
    # end
    
    
    
  end
  
end
