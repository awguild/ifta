class Price < ActiveRecord::Base
  attr_accessible :country_category, :amount, :discount_key, :member, :conference_item_id
  belongs_to :conference_item
  belongs_to :discount, :foreign_key => 'discount_key'
  validates :amount, :format => { :with => /^\d+??(?:\.\d{0,2})?$/ }, :numericality => {:greater_than_or_equal_to => 0}

  scope :user_price, lambda{|user| where('country_category=? AND member=?', user.country_category, user.member)}

  def <=>(other)
    if self.member != other.member
      return self.member ? -1 : 1
    else
      return self.country_category <=> other.country_category
    end
  end
end
