class LineItem < ActiveRecord::Base
  #Note: Pricing is a bit confusing. A valid price is stored when the line_item is created
  #the validity of that price can expire before it is actually paid through a transaction though
  #the line_item price should be authorative once set despite being listed in attr_accesible
  #because only admins can update line_items

  #associations
  belongs_to :conference_item
  belongs_to :transaction
  belongs_to :itinerary
  delegate :user, :to => :itinerary #slick, check out what this allows in the Ability class

  #validations
  validates :itinerary, :existence => true
  validates :conference_item_id, :existence => true
  validates :price, :format => { :with => /^\d+??(?:\.\d{0,2})?$/ }, :numericality => {:greater_than_or_equal_to => 0}
  validate :check_price

  def self.total_price(line_items)
    return line_items.inject(0){|sum, item| sum + item.price}.round(2)
  end

  private

  def check_price
    return false if (conference_item.blank? || itinerary.blank?)
    #Line item fields are all safe to use since they are checked for existence during the validations
    server_price = conference_item.item_price(itinerary.user, itinerary.discount_key)
    if (price == server_price) || conference_item.manual_price
      return true
    else
      errors.add(:price, "does not match our records.  It should be $#{server_price} Try reloading the page.")
      return false
    end
  end

end
