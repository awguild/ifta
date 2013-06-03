class Discount < ActiveRecord::Base
  attr_accessible :discount_key, :description, :prices_attributes
  has_many :itineraries, :foreign_key => "discount_key"
  has_many :prices, :foreign_key => "discount_key"
  has_many :conference_items, :through => :prices
  belongs_to :conference
  after_initialize :setup, :if => 'new_record? && prices.blank?'
  before_create 'self.discount_key = SecureRandom.hex'
  
  accepts_nested_attributes_for :prices, allow_destroy: true
  
  private
  
  def setup
    #build a new price item for each conference item that has been declared for this conference
    conference.conference_items.each do |item|
      self.prices << item.prices.build(:discount_key => self.discount_key) 
    end
  end
end
