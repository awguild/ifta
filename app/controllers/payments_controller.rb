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

  def new
    @conference = selected_conference
    @payment = Payment.new
    @transactions = Transaction.search_for_transactions(params).page(params[:page]).per_page(20).includes(:itinerary => [:user], :line_items => [:conference_item])
    authorize! :create, @payment
  end

  #When IFTA gets checks or bank transfers the event planners have to mark the payments in the system as paid
  def admin_create
    @payment = Payment.new(params[:payment])
    authorize! :create, @payment
    if @payment.save
      PaymentMailer.payment_notification(@payment).deliver if params[:send_email]
      redirect_to after_sign_in_path_for(current_user) 
    else
      render :action => 'new'
    end
  end
  
  def update
    @payment = Payment.find(params[:id])
    authorize! :update, @payment
    if @payment.update_attributes(params[:payment])
      render "update", :locals => {:notice_message => 'Successfully Updated Payment'}
    else
      render :partial => 'shared/error_messages', :locals => {:object => @line_item}
    end
  end
  
  def destroy
    @payment = Payment.find(params[:id])
    authorize! :destroy, @payment
    @payment.destroy
    redirect_to after_sign_in_path_for(current_user)
  end
end
