class ItinerariesController < ApplicationController
  before_action :check_contact_info

  #Paypal sends the user back here
  def index
    redirect_to edit_itinerary_path(current_user.itineraries.last) #not after_sign_in_path since reviewers and admins might pay with paypal and they should be returned to the registration interface
  end

  #the itinerary edit page is THE MAIN INTERFACE for attendee registration
  #so... this page has mission creeped and is a bit messy
  #it functions like a 'new' page for line_items and transactions
  #NOTE: the itinerary isn't responsible for creating, updating, or destroying either of those resources though
  #it also acts like an 'index' page for proposals
  def edit
    @itinerary = Itinerary.find(params[:id])
    authorize! :update, @itinerary
  end

  def update
    @itinerary = Itinerary.find(params[:id])
    authorize! :update, @itinerary

    if @itinerary.update(itinerary_params)
      redirect_to edit_itinerary_path(@itinerary)
    else
      render 'edit'
    end
  end

  private

  def itinerary_params
    params.require(:itinerary).permit(:discount_key, :conference_id)
  end

end
