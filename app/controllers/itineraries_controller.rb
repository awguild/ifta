class ItinerariesController < ApplicationController
  before_filter :check_contact_info
  #before_filter :session_url_itinerary_match
  
  #Paypal sends the user back here
  def index
    redirect_to :action => "edit", :id => current_user.id
  end
  
  #the itinerary edit page is THE MAIN INTERFACE for attendees
  #so this page has mission creeped and is a bit messy 
  #it functions like a 'new' page for line_items and transactions (they are not nested in the itinerary though)
  #and an 'index' page for proposals
  def edit
    @itinerary = Itinerary.find(params[:id])
    @user = @itinerary.user
    authorize! :update, @itinerary
  end
  
  def update
    @itinerary = Itinerary.find(params[:id])
    authorize! :update, @itinerary
    
    if @itinerary.update_attributes(params[:itinerary])
      redirect_to edit_itinerary_path(@itinerary)
    else
      render 'edit'
    end
    
  end

end
