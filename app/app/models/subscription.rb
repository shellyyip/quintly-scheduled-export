class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
      record.errors[attribute] << (options[:message] || "is not an email")
    end
  end
end

class Subscription < ActiveRecord::Base
  validates :email, presence: true, email: true
  validates :vendor, presence: true
  validates :frequency, presence: true
    
  scope :quintly, -> { where(vendor: 'Quintly') }
end

class QuintlyWorker
  include Sidekiq::Worker  
  def perform(id)
    puts '****************** RUNNING QUINTLY TASK NUMBER '+id.to_s
  end
end