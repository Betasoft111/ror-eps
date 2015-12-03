# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
EPS::Application.initialize!
# ActionMailer::Base.delivery_method = :smtp
# ActionMailer::Base.raise_delivery_errors = :true
# ActionMailer::Base.perform_deliveries = :true
# #ActionMailer::Base.default_charset = "utf-8"
# ActionMailer::Base.server_settings = {
#   :address => "mail.mydomain.com",
#   :port => 25,
#   :domain => "mydomain.com",
#   :user_name => "myusername",
#   :password => "mypassword",
#   :authentication => :login
# }
Paperclip.options[:command_path] = "/usr/bin/convert/"