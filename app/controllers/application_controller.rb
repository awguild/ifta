class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!
  before_filter :check_active_conference
  
  #overriding a devise helper method
  def after_sign_in_path_for(user)
    #Every user should have a conference itinerary, if you can't find one make it
    user.itineraries.create({conference_id: Conference.active}) if user.itineraries.current.empty?
    
    #role based after sign in path
    if user.is_reviewer?
      return conference_proposals_path(Conference.active)
    elsif user.is_admin?
      return conference_path(Conference.active)
    elsif user.is_attendee?
      return edit_itinerary_path(user.itineraries.current.first )
    else
      raise "Unknown user role"
    end
  end
  
  #overriding a devise helper method
  def after_sign_up_path_for(user)
    after_sign_in_path_for(user)
  end

  # return the currently active conference or the confernece selected by the session variable selected_conference_id
  def current_conference
    if session[:selected_conference_id].blank?
      Conference.active
    else
      begin 
        Conference.find(session[:current_conference_id])
      rescue ActiveRecord::RecordNotFound
        session[:selected_conference_id] = nil
        Conference.active
      end    
    end
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
  helper_method :current_conference
  
end
