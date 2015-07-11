class Country < ActiveRecord::Base
  has_many :users

  default_scope -> { order('name') }
end
