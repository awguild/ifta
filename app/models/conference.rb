#Conferences are the main administrative resource, they define a bunch of settings
#and own conference items (which are what users)
class Conference < ActiveRecord::Base
  has_paper_trail 
  
  attr_accessible :conference_year, :tax_rate, :conference_items_attributes, :active
  
  has_many :conference_items
  has_many :line_items, :through => :conference_items
  
  has_many :itineraries
  has_many :proposals, :through => :itineraries
  
  validates :tax_rate, :numericality => {
    :greater_than_or_equal_to => 0,
    :less_than_or_equal_to => 1
  }
  
  accepts_nested_attributes_for :conference_items, allow_destroy: true
  
  def self.active
    Conference.find_by_active(true) || Conference.new 
    #TODO Log into different conferences SESSION VARIABLE || find_by_active
  end
  
  def proposal_count
    proposals.count
  end
  
  def registration_count
    line_items.count
  end
end
