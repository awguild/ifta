class Day < ActiveRecord::Base
  attr_accessible :label, :time_slots_attributes, :day_date
  belongs_to :schedule, :autosave => true
  has_many :time_slots, :autosave => true
  
  accepts_nested_attributes_for :time_slots
end
