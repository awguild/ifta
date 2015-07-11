class Schedule < ActiveRecord::Base
  #associations
  has_many :slots, -> { order 'start_time' }
  has_many :rooms
  belongs_to :conference
end
