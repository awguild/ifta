class PaymentMailer < ActionMailer::Base
  default from: CONFIG[:gmail_username]
  
  def payment_notification(payment)
    @user = payment.user
    @payment = payment
    mail(:to => @user.email, :subject => "IFTA Conference Payment Received")
  end
end
