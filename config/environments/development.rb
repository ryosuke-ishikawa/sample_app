SampleApp::Application.configure do
# number of complex assets.
  config.assets.debug = true
  
  # Don't care if the mailer can't send.
config.action_mailer.raise_delivery_errors = true
config.action_mailer.default_url_options = { :host => 'https://sample-app-takayukishinozaki.c9.io', :port => 8080 }
config.action_mailer.delivery_method = :smtp
config.action_mailer.smtp_settings = {
  :address => 'smtp.gmail.com',
  :port => 587,
  :domain => 'c9.io',
  :user_name => ENV['SMTP_MAIL'],
  :password => ENV['SMTP_PASS'],
  :authentication => :plain,
  :enable_starttls_auto => true
}

end