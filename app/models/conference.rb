#Conferences are the main administrative resource, they define a bunch of settings
#and own conference items (which are what users)
class Conference < ActiveRecord::Base
  #associations
  has_many :conference_items
  has_many :line_items, :through => :conference_items
  has_many :discounts
  has_many :itineraries
  has_many :proposals
  has_many :presenters, :through => :proposals

  accepts_nested_attributes_for :conference_items, allow_destroy: true

  #validations
  validates :tax_rate, :numericality => {
    :greater_than_or_equal_to => 0,
    :less_than_or_equal_to => 1
  }
  validates :conference_year, :uniqueness => { :case_sensitive => false}

  #life cycle hooks
  after_save :enforce_one_active_conference

  def registration_breakdown
    conference_items.map do |item|
      {
        name: item.name,
        registrant_count: item.number_of_paid_registrants
      }
    end
  end

  # essentially a named scope, but implemented as a class method beecause scopes must be chainable and find_by isn't chainable
  def self.active
    find_by(active: true)
  end

  def to_param
    conference_year.to_s
  end

  def paid_items_by_user
    itineraries.includes(:line_items, :conference_items).reduce({}) do |acc, itin|
      acc[itin.user_id] = itin.line_items.select(&:paid).map do |item|
                            item.conference_item.name
                          end
      acc
    end
  end

  private

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
