class Room < ActiveRecord::Base
  has_many :proposals
  belongs_to :schedule
  has_one :conference, :through => :schedule
  has_many :slots

  validates :schedule, presence: true
end
