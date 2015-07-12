class TimeBlock < ActiveRecord::Base
  has_many :slots
  belongs_to :room
  belongs_to :proposal
end
