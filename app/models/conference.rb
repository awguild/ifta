#Conferences are the main administrative resource, they define a bunch of settings
#and own conference items (which are what users)
class Conference < ActiveRecord::Base
  attr_accessible :conference_year, :tax_rate, :conference_items_attributes, :active

  #associations
  has_many :conference_items
  has_many :line_items, :through => :conference_items
  has_many :discounts
  has_many :itineraries
  has_many :proposals
  has_one :schedule
  has_many :rooms, :through => :schedule
  has_many :slots, :through => :schedule

  accepts_nested_attributes_for :conference_items, allow_destroy: true

  #validations
  validates :tax_rate, :numericality => {
    :greater_than_or_equal_to => 0,
    :less_than_or_equal_to => 1
  }
  validates :conference_year, :uniqueness => true

  #life cycle hooks
  after_save :enforce_one_active_conference
  after_create :build_schedule


  #returns the number of proposals scoped to this conference
  def proposal_count
    proposals.count
  end

  def accepted_proposal_count
    proposals.accepted.count
  end

  def wait_listed_proposal_count
    proposals.wait_listed.count
  end

  def registration_count
    line_items.where(:paid => true).count
  end

  def pending_registration_count
    line_items.where(:paid => false).count
  end

  def registration_breakdown
    conference_items.map do |item|
      {
        name: item.name,
        registrant_count: item.number_of_paid_registrants
      }
    end
  end

  # essentially a named scope, but implemented as a class method beecause scopes must be chainable and find_by_x isn't chainable
  def self.active
    find_by_active(true)
  end

  def to_param
    conference_year
  end

  private

  #creates a schedule for this conference
  def build_schedule
    create_schedule({:conference_id => id})
  end

  def enforce_one_active_conference
    # if the current conference is going to be active then there cannot be any other active conferneces
    if Conference.where(active: true).count == 0
      self.update_column(:active, true)
    elsif Conference.where(active: true).count > 1
       Conference.where(active: true).each do |conference|
        conference.update_column(:active, false)
      end
      self.update_column(:active, true)
    end
  end
end
