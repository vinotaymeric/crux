# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

 # Setup email service
ActionMailer::Base.smtp_settings = {
 :address              => "smtp.gmail.com",
 :port                 => 587,
 :user_name            => ENV['GMAIL_ADDRESS'],
 :password             => ENV['GMAIL_APP_PASSWORD'],
 :authentication       => "plain",
 :enable_starttls_auto => true
}
