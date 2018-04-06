class Presenter < ActiveRecord::Base
  #associations
  belongs_to :proposal
  belongs_to :country

  #validations
  validates :first_name, :last_name, :email, :country_id, :highest_degree, :graduating_institution, :qualifications, :presence => true

  def reverse_full_name
    "#{last_name}, #{first_name}"
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def country_name
    country.try(:name) || 'N/A'
  end

  def self.presenter_conference_status(email, conference_id)
    #look for a user with the given email
    user = User.where(:email => email).first
    return 'No User' if user.blank?
    #look for itinerary for the relevant conference
    itinerary = user.itineraries.find_by(conference_id: conference_id)

    if itinerary.try(:registered_for_conference?)
      return 'Registered'
    elsif itinerary.try(:has_pending_conference_registration?)
      return 'Pending Registration'
    else
      return 'Not Registered'
    end
  end
end
