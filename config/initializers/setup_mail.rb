require 'development_mail_interceptor'
ActionMailer::Base.register_interceptor(DevelopmentMailInterceptor) unless Rails.env.production?

# SMTP Connection Settings
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.perform_deliveries = true
ActionMailer::Base.raise_delivery_errors = true
ActionMailer::Base.smtp_settings = {
:address              => "smtp.gmail.com",
:port                 => 587,
:domain               => ENV["GMAIL_DOMAIN"],
:user_name            => ENV["GMAIL_USERNAME"],
:password             => ENV["GMAIL_PASSWORD"],
:authentication       => 'plain',
:enable_starttls_auto => true  }

