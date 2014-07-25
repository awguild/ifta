class Discount < ActiveRecord::Base
  attr_accessible :discount_key, :description, :prices_attributes

  #associations
  has_many :itineraries, :foreign_key => "discount_key", :primary_key => "discount_key"
  has_many :prices, :foreign_key => "discount_key", :primary_key => "discount_key"
  has_many :conference_items, :through => :prices
  belongs_to :conference

  accepts_nested_attributes_for :prices, allow_destroy: true

  #validations
  validates :discount_key, :uniqueness => true
  validates :discount_key, length: { is: 6 }

  #life cycle hooks
  after_initialize :generate_key, :if => 'discount_key.blank?'

  #build a new price item for each conference item that has been declared for this conference
  def build_prices_for_conference_items
    return false if conference.blank?

    conference.conference_items.each do |item|
      prices << item.prices.build(:discount_key => discount_key)
    end
    true
  end

  private

  def generate_key
    self.discount_key = SecureRandom.hex[0,6]
  end
end
