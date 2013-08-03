#Conferences are the main administrative resource, they define a bunch of settings
#and own conference items (which are what users)
class Conference < ActiveRecord::Base
  has_paper_trail 
  
  attr_accessible :conference_year, :tax_rate, :conference_items_attributes, :active
  
  has_many :conference_items
  has_many :line_items, :through => :conference_items
  has_many :discounts
  has_many :itineraries
  has_many :proposals, :through => :itineraries
  has_one :schedule
  
  accepts_nested_attributes_for :conference_items, allow_destroy: true
  
  validates :tax_rate, :numericality => {
    :greater_than_or_equal_to => 0,
    :less_than_or_equal_to => 1
  }
  after_create :build_schedule
  
  #returns the active conference or a new confernece
  def self.active
    Conference.find_by_active(true) || Conference.new 
    #TODO Log into different conferences SESSION VARIABLE || find_by_active
  end
  
  #returns the number of proposals scoped to this conference
  def proposal_count
    proposals.count
  end
  
  #returns the number of line_items scoped to this model
  #Note: this statistic is not the same as the number of people registered
  def registration_count
    line_items.count
  end
  
  private
  #creates a schedule for this conference
  def build_schedule
    build_schedule(:conference_id => id)
  end
end
