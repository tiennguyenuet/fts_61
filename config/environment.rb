# Load the Rails application.
require File.expand_path('../application', __FILE__)
config.gem "active_link_to"
# Initialize the Rails application.
Rails.application.initialize!
ActionMailer::Base.smtp_settings = {
  user_name: ENV["GMAIL_USERNAME"],
  password: ENV["GMAIL_PASSWORD"],
  domain: "gmail.com",
  address: "smtp.gmail.com",
  port: 587,
  authentication: :plain,
  enable_starttls_auto: true
}
