class TransactionsController < ApplicationController
  
  #When the transaction is created 
  def show
    @transaction = Transaction.find(params[:id])
    authorize! :create, @transaction
    @user = @transaction.user
  end
  
  #Transactions are a group of line items (priced conference items), total tax on those items, and a payment method
  #Transaction creation isn't exactly done the rails way because the interface to create a new transaction 
  #is embeded in the itineraries edit page, so all the loading is logically tied to the itineraries edit action
  #but I didn't embed transaction creation as a nested model of itineraries, so we flip over to this controller to actually create a transaction
  def create
    @itinerary = Itinerary.find(params[:itinerary_id])
    @transaction = @itinerary.transactions.build
    authorize! :create,  @transaction 
    
    @unpaid_line_items = @itinerary.line_items.find_all_by_paid(false)
    @transaction.line_items = @unpaid_line_items
    @transaction.tax = @transaction.pre_tax_total * Conference.active.tax_rate
    @transaction.payment_method = params[:payment_method]
    
    if @transaction.save
      redirect_to itinerary_transaction_path(@itinerary, @transaction)
    else
      #TODO there isn't any user input that could cause this action to fail, so probably apologize and send the developer an email.. 
    end
  end
  
  def destroy
    @transaction = Transaction.find(params[:id])
    authorize! :destroy, @transaction
    @transaction.destroy
    redirect_to after_sign_in_path_for(current_user)
  end
  
end
