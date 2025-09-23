require 'development_mail_interceptor'
ActionMailer::Base.register_interceptor(DevelopmentMailInterceptor) unless Rails.env.production?

# SMTP Connection Settings
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.perform_deliveries = true
ActionMailer::Base.raise_delivery_errors = true
ActionMailer::Base.smtp_settings = {
:address              => "mail.smtp2go.com",
:port                 => 587,
:domain               => "ifta-congress.org",
:user_name            => ENV["SMTP2GO_USERNAME"],
:password             => ENV["SMTP2GO_PASSWORD"],
:authentication       => 'plain',
:enable_starttls_auto => true  }

