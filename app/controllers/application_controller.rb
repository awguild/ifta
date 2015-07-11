class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!

  #overriding a devise helper method
  def after_sign_in_path_for(user)
    #Every user should have a conference itinerary, if you can't find one make it
    user.itineraries.create({conference_id: selected_conference.id}) if user.itineraries.find_by(conference_id: selected_conference.id).blank?

    #role based after sign in path
    if user.is_reviewer?
      return conference_proposals_path(selected_conference)
    elsif user.is_admin?
      return conference_path(selected_conference)
    elsif user.is_attendee?
      return edit_itinerary_path(user.itineraries.find_by(conference_id: selected_conference))
    else
      raise "Unknown user role"
    end
  end

  #overriding a devise helper method
  def after_sign_up_path_for(user)
    after_sign_in_path_for(user)
  end

  # return the currently active conference or the confernece selected by the session variable selected_conference_id
  def selected_conference
    return @selected_conference unless @selected_conference.blank?
    if session[:selected_conference_id].blank?
      @selected_conference = Conference.active
    else
      begin
        @selected_conference = Conference.find(session[:selected_conference_id])
      rescue ActiveRecord::RecordNotFound
        session[:selected_conference_id] = nil
        @selected_conference = Conference.active
      end
    end
  end


  #before filter which renders the user contact_info partial if the user isn't in a valid state
  def check_contact_info
    @user = current_user
    if @user.invalid?
     return redirect_to edit_user_path(current_user)
    end
  end


  helper_method :after_sign_in_path_for
  helper_method :selected_conference

end
