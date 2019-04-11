# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

 # Setup email service
ActionMailer::Base.smtp_settings = {
  :user_name => ENV['SENDGRID_USERNAME'],
  :password => ENV['SENDGRID_PASSWORD'],
  :domain => 'cruxadventures.pro',
  :address => 'smtp.sendgrid.net',
  :port => 587,
  :authentication => :plain,
  :enable_starttls_auto => true
}
