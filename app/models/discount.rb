class Discount < ActiveRecord::Base
  # attr_accessible :title, :body
  has_many :itineraries, :foreign_key => "discount_key"
end
