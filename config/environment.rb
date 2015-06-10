# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

ActionMailer::Base.smtp_settings = {
:address => 'smtpout.secureserver.net',
:domain  => 'www.godaddy.com',
:port      => 80,
:user_name => 'admin@mbanumbers.com',
:password => 'asif786',
:authentication => :plain
}