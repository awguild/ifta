class Price < ActiveRecord::Base
  include Comparable
  WHITE_LISTED = [:country_category, :amount, :discount_key, :member, :conference_item_id]

  #associations
  belongs_to :conference_item
  belongs_to :discount, :foreign_key => 'discount_key'

  #query
  scope :user_price, lambda {|user| where('country_category=? AND member=?', user.country_category, user.member)}

  #validations
  validates :amount, :format => { :with => /^\d+??(?:\.\d{0,2})?$/ }, :numericality => {:greater_than_or_equal_to => 0}

  # sort prices by membership and then country category
  # e.g. member=true country_category=1 < member=true country_category=2 // true
  # e.g. member=false country_category=1 < member=true country_category=2 // false
  def <=>(other)
    if self.member != other.member
      return self.member ? -1 : 1
    else
      return self.country_category <=> other.country_category
    end
  end
end
