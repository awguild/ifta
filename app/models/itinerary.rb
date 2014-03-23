#For every conference each user has an itinerary (this is post condition of sign in)
#users register for conference items by adding line items (conference item + price) to an itinerary
#transactions group unpaid line items together to allow the user to pay for them via Paypal, check, or bank transfer
class Itinerary < ActiveRecord::Base
  attr_accessible :discount_key, :conference_id

  belongs_to :user
  belongs_to :conference
  belongs_to :discount, :foreign_key => "discount_key", :primary_key => "discount_key"
  has_many :line_items
  has_many :conference_items, :through => :line_items
  has_many :proposals
  has_many :transactions

  validates :discount, :existence => true, :unless => "discount_key.blank?"

  #Finding conference items and line items by various criteria
  def unpaid_line_items
    @unpaid_line_items ||= line_items.find_all_by_paid(false)
  end

  def paid_line_items
    @paid_line_items = line_items.find_all_by_paid(true)
  end

  def available_conference_items
    @available_items = discounted_conference_items + regular_priced_conference_items
  end

  def any_items?
    return !(regular_priced_conference_items.blank? && discounted_conference_items.blank? && paid_line_items.blank? && unpaid_line_items.blank?)
  end

  #Calculating price information on line items
  def line_items_pre_tax_price
    @pre_tax ||= LineItem.total_price(unpaid_line_items)
  end

  def line_items_tax_price
    @tax = line_items_pre_tax_price * Conference.active.tax_rate
  end

  private

  #helper methods for finding available conference items
  def discounted_conference_items
    @discounted_items ||= ConferenceItem.discounted_items(discount_key).not_registered(line_items)
  end

  def regular_priced_conference_items
    @regular_priced_items ||= ConferenceItem.regular_priced_items(user).not_registered(line_items).not_discounted(discounted_conference_items)
  end
end
