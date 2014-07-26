class Schedule < ActiveRecord::Base
  attr_accessible :conference_id, :days_attributes, :time_slots_attributes, :slots_attributes, :rooms_attributes
  
  #associations
  has_many :days, :autosave => true
  has_many :time_slots, :through => :days, :autosave => true
  has_many :slots, :through => :time_slots, :order => 'start_time'
  has_many :rooms
  belongs_to :conference

  accepts_nested_attributes_for :days, :allow_destroy => true
  accepts_nested_attributes_for :time_slots, :allow_destroy => true
  accepts_nested_attributes_for :slots, :allow_destroy => true
  accepts_nested_attributes_for :rooms, :allow_destroy => true
end
