class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!
  before_filter :check_active_conference
  
  #Reviewers, admins, & attendees each have a resource to edit as their main interface
  #that resource should be blank when user accounts are created and when the conference gets rolled yearly
  #this method ensures that when users log in they have an editable resource and redirects to that resource
  def after_sign_in_path_for(user)
    
    if user.role == 'reviewer'
      return conference_proposals_path(Conference.active)
    elsif user.role == 'admin'
      return conference_path(Conference.active)
    else
      if user.itineraries.current.empty?
        user_itinerary = Itinerary.new
        user_itinerary.conference = Conference.active
        user_itinerary.user = user
        user_itinerary.save
      end
      user_itinerary = user.itineraries.current.first      
      return edit_itinerary_path(user_itinerary)
    end
  end
  
  def after_sign_up_path_for(user)
    after_sign_in_path_for(user)
  end
  
  
  #Loads the user contact_info partial if an attendee's country isn't set
  def check_contact_info
    #TODO currently this manually checks the country, but with conditional validations on the user model
    #this could be changed to run the validation suite
    if current_user.role == "attendee" && current_user.country_category.blank?
     @user = current_user
     render 'users/shared/_contact_info.html.erb'
     return false
    end
  end
  
  def check_active_conference
    if Conference.active.blank?
      render 'shared/_conference_closed', :layout => 'application'
      return false
    end
  end
  
  helper_method :after_sign_in_path_for
  
end
