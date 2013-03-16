class PaymentsController < ApplicationController
  #let paypal access the create action as an anynonmous user
  protect_from_forgery :except => :create 
  skip_before_filter :authenticate_user!, :only => :create
  
  #This action only handles the Payments created through the PayPal IPN Process
  def create
    #PaypalCallback object sends the raw post request to paypal and expects to get VERIFIED back
    response = PaypalCallback::PaypalCallback.new(params, request.raw_post, CONFIG[:paypal_post_url])
    
    #check that the payment says completed & paypal verifies post content
    if response.completed? && response.valid? 
      @transaction = Transaction.find(params[:invoice]) #invoice is a pass through variable that gets embedded in the encrpyted paypal form and we get it back here     
      Payment.create(:params => params, :transaction_id => @transaction.id, :amount => params['payment_gross'], :confirmed => true)
    else
      #TODO maybe send out some type of alert to an admin
    end
    render :nothing => true
  end
  
  
end
