
class ConferenceItem < ActiveRecord::Base
  has_paper_trail
  attr_accessible :name, :description, :multiple, :max, :visibility, :prices_attributes, :manual_price, :user_comment, :user_comment_prompt, :conference_id

  belongs_to :conference
  has_many :prices
  has_many :line_items
  has_many :itineraries, :through => :line_items
  has_many :regular_prices, :conditions => {:discount_key => nil}, :class_name => 'Price' #exclude all of the prices created for this item that have a discount key set

  after_initialize :build_price_objects, :if => "prices.blank?" #When a new conference item is created the event planners will probably want to price these six categories

  accepts_nested_attributes_for :prices, allow_destroy: true

  scope :current_active, ->{ where("visibility=? AND conference_id='?'", true, Conference.active.id) }
  scope :not_registered, lambda{|line_items| where("conference_items.id not in (?)", line_items.blank? ? '' : line_items.collect(&:conference_item_id))}
  scope :not_discounted, lambda{|discounted_items| where("conference_items.id not in (?)", discounted_items.blank? ? '' : discounted_items.collect(&:id))}
  #I couldn't figure out a single sql query that would inner join prices and conference items where the itinerary discount key matches price discount key, or (if no such price exists) where price country_category + member matches same fields in user
  #So instead I find the discounted items first and then price all the conference items that aren't in discounted items


  #look up a conference item's price by discount key first, and then by user country + member status
  def item_price(user, discount_key)
    (price_with_discount(discount_key) || price_for_user(user)).amount
  end

  #loads and memoizes price objects for the given conference item
  #can't use a query because we want to include price objects that have been built but not persisted yet
  def sorted_regular_prices
    @sorted_regular_prices ||= sorted_prices_without_discounts
  end

  #loads and memoizes the number of registrations for this conference item
  def number_of_paid_registrants
    @number_of_paid_registrants ||= line_items.where(paid: true).count
  end

  #loads all the conference items for a user from the active conference with a price for each item
  def self.regular_priced_items(user)
    current_active.joins(:prices).where('prices.country_category=? AND prices.member=?', user.country_category, user.member).select("conference_items.*, prices.amount as price")
  end

  #loads all the conference items for the discount key from the active conference with a price for each item
  def self.discounted_items(discount_key)
    current_active.joins(:prices).where('prices.discount_key=?', discount_key).select("conference_items.*, prices.amount as price")
  end

  private

  #get the normal price for this person
  def price_for_user user
    prices.user_price(user).first
  end

  #get the discount price if it's set
  def price_with_discount discount_key
      discount_key.blank? ? nil : prices.where('discount_key=?', discount_key).first
  end

  def build_price_objects
    prices.build(:country_category => 1, :member => true)
    prices.build(:country_category => 2, :member => true)
    prices.build(:country_category => 3, :member => true)
    prices.build(:country_category => 4, :member => true)
    prices.build(:country_category => 1, :member => false)
    prices.build(:country_category => 2, :member => false)
    prices.build(:country_category => 3, :member => false)
    prices.build(:country_category => 4, :member => false)
  end

  def sorted_prices_without_discounts
    self.prices.select {|price| price.discount_key.blank? ? price : nil}.sort
  end
end
