
class ConferenceItem < ActiveRecord::Base
  has_paper_trail 
  attr_accessible :name, :description, :multiple, :max, :visibility, :prices_attributes, :manual_price, :user_comment, :user_comment_prompt
  
  belongs_to :conference
  has_many :prices
  has_many :line_items
  has_many :itineraries, :through => :line_items
  has_many :regular_prices, :conditions => {:discount_key => nil}, :class_name => 'Price'
  
  after_initialize :build_price_objects, :if => "prices.blank?" #When a new conference item is created the event planners will probably want to price these six categories
  
  accepts_nested_attributes_for :prices, allow_destroy: true 
  
  scope :current_active, where("visibility=? AND conference_id='?'", true, Conference.active.id)
  scope :not_registered, lambda{|line_items| where("conference_items.id not in (?)", line_items.blank? ? '' : line_items.collect(&:conference_item_id))}
  scope :not_discounted, lambda{|discounts| where("conference_items.id not in (?)", discounts.blank? ? '' : discounts.collect(&:id))}
  #I couldn't figure out a single sql query that would inner join prices and conference items where the itinerary discount key matches price discount key, or (if no such price exists) where price country_category + member matches same fields in user
  #So instead I find the discounted items first and then price all the conference items that aren't in discounted items
  
  
  #Line Item creation checks that a conference item is being priced correctly by calling this method
  def item_price(itinerary)
    #get the normal price for this person
    price = prices.where('country_category=? AND member=?', itinerary.user.country_category, itinerary.user.member).first
    #get the discount price if it's set
    if !itinerary.discount_key.blank?
      discount_price =  prices.where('discount_key=?', itinerary.discount_key).first 
      price = discount_price unless discount_price.blank?
    end
    #return nil if the price isn't set
    return price.blank? ? nil : price.amount 
  end
  
  def self.regular_priced_items(user)
    current_active.joins(:prices).where('prices.country_category=? AND prices.member=?', user.country_category, user.member).select("conference_items.*, prices.amount as price")
  end
  
  def self.discounted_items(itinerary)
    current_active.joins(:prices).where('prices.discount_key=?', itinerary.discount_key).select("conference_items.*, prices.amount as price")
  end
   
  private 
   
  def build_price_objects
    prices.build(:country_category => 1, :member => true)
    prices.build(:country_category => 2, :member => true)
    prices.build(:country_category => 3, :member => true)
    prices.build(:country_category => 1, :member => false)
    prices.build(:country_category => 2, :member => false)
    prices.build(:country_category => 3, :member => false)
  end
end
