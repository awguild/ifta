class Country < ActiveRecord::Base
  # attr_accessible :title, :body
  has_many :users

  default_scope order('name')
end
