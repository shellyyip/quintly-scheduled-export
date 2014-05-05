class ScheduledMailer < ActionMailer::Base
  default from: "mullenmailer@gmail.com"
  
  def sendcsvemail(csv)
    attachments['quintly.csv'] = {mime_type: 'application/csv',
                                  content: csv }
    mail( to: 'snjoo@mullen.com', 
          subject: 'Your scheduled Quintly CSV',
          content_type: 'text/html',
          body: 'testing!')
  end
  
end
