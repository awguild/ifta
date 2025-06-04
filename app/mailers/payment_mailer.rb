class PaymentMailer < ActionMailer::Base
  default from: "IFTA Conference  <#{ENV["GMAIL_USERNAME"]}>",
          reply_to: ENV["GMAIL_REPLY_TO"]

  def payment_notification(payment)
    @user = payment.user
    @payment = payment
    mail(:to => @user.email, :subject => "IFTA Conference Payment Received")
  end
end
