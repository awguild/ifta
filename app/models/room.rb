class Room < ActiveRecord::Base
  attr_accessible :label, :audio, :video
  has_many :proposals
  belongs_to :schedule
  has_one :conference, :through => :schedule

  validates :schedule, presence: true
end
