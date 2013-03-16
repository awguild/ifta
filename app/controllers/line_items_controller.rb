class LineItemsController < ApplicationController
  
  #Line items are conference items coupled with a price in the users cart
  #The admins can add line items on behalf of users since the itinerary is URL loaded (doesn't rely on current_user)
  def create 
    @itinerary = Itinerary.find(params[:itinerary_id])
    @line_item = @itinerary.line_items.build(params[:line_item])    
    authorize! :create, @line_item unless @line_item.invalid? #the authorize! method expects valid associations
        
    if @line_item.save
      @tax_rate = Conference.active.tax_rate
      render "create"
    else
       render :partial => 'shared/error_messages', :locals => {:object => @line_item}
       return false
    end  
  end
  
  #Users can remove line items from their cart unless they have been marked as paid
  #which happens through the PayPal IPN process or through the admins manually marking them paid (checks and bank transfers)
  def destroy
    @line_item = LineItem.find(params[:id])
    authorize! :destroy, @line_item
    @line_item.destroy
    redirect_to edit_itinerary_path(@line_item.itinerary)
  end

  
  
end
