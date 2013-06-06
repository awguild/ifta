class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!
  before_filter :check_active_conference
  
  #overriding a devise helper method
  def after_sign_in_path_for(user)
    #Every user should have a conference itinerary, if you can't find one make it
    if user.itineraries.current.empty?
      user_itinerary = Itinerary.new
      user_itinerary.conference = Conference.active
      user_itinerary.user = user
      user_itinerary.save
    end
    
    #role based after sign in path
    if user.role == 'reviewer'
      return conference_proposals_path(Conference.active)
    elsif user.role == 'admin'
      return conference_path(Conference.active)
    else 
      return edit_itinerary_path(user.itineraries.current.first )
    end
  end
  
  #overriding a devise helper method
  def after_sign_up_path_for(user)
    after_sign_in_path_for(user)
  end
  
  
  #before filter which renders the user contact_info partial if the user isn't in a valid state
  def check_contact_info
    @user = current_user
    if @user.invalid?
     render 'users/shared/_contact_info.html.erb'
     return false
    end
  end
  
  #before filter which renders a splash page if there is no active conference
  def check_active_conference
    if Conference.active.blank?
      render 'shared/_conference_closed', :layout => 'application'
      return false
    end
  end
  
  helper_method :after_sign_in_path_for
  
end
