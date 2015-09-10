class Schedule < ActiveRecord::Base
  #associations
  has_many :time_blocks, -> { order 'start_time' }
  has_many :slots, through: :time_blocks
  has_many :rooms
  belongs_to :conference
end
