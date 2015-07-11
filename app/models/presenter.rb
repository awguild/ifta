class Presenter < ActiveRecord::Base
  #associations
  belongs_to :proposal

  #validations
  validates :first_name, :last_name, :email, :presence => true

  def self.presenter_conference_status(email, conference_id)
    #look for a user with the given email
    user = User.where(:email => email).first
    return 'No User' if user.blank?
    #look for itinerary for the relevant conference
    itinerary = user.itineraries.find_by(conference_id: conference_id)

    if itinerary.registered_for_conference?
      return 'Registered'
    elsif itinerary.has_pending_conference_registration?
      return 'Pending Registration'
    else
      return 'Not Registered'
    end
  end
end
