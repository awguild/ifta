require 'development_mail_interceptor' 
ActionMailer::Base.register_interceptor(DevelopmentMailInterceptor) if Rails.env.development?  

# SMTP Connection Settings
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.perform_deliveries = true
ActionMailer::Base.raise_delivery_errors = true
ActionMailer::Base.smtp_settings = {
:address              => "smtp.gmail.com",
:port                 => 587,
:domain               => CONFIG[:gmail_domain],
:user_name            => CONFIG[:gmail_username],
:password             => CONFIG[:gmail_password],
:authentication       => 'plain',
:enable_starttls_auto => true  }
  
