class Schedule < ActiveRecord::Base
  attr_accessible :conference_id, :days_attributes
  belongs_to :conference
  has_many :days, :autosave => true
  has_many :time_slots, :through => :days, :autosave => true
  accepts_nested_attributes_for :days
end
