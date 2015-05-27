class Schedule < ActiveRecord::Base
  attr_accessible :conference_id

  #associations
  has_many :slots, :order => 'start_time'
  has_many :rooms
  belongs_to :conference

end
