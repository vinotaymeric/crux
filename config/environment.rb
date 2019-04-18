# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!
# Set the root url, depending on the environment
Rails.application.default_url_options = Rails.application.config.action_mailer.default_url_options
