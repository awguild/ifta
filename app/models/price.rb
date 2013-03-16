class Price < ActiveRecord::Base
  attr_accessible :country_category, :amount, :discount_key, :member
  belongs_to :conference_item
  
  validates :amount, :format => { :with => /^\d+??(?:\.\d{0,2})?$/ }, :numericality => {:greater_than => 0}
  
  def <=>(other)
    if self.member != other.member
      return self.member ? -1 : 1
    else
      return self.country_category <=> other.country_category
    end  
  end
end
