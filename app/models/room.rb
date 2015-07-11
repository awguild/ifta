class Room < ActiveRecord::Base
  has_many :proposals
  belongs_to :schedule
  has_one :conference, :through => :schedule

  validates :schedule, presence: true
end
