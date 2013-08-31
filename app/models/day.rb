class Day < ActiveRecord::Base
  attr_accessible :label, :time_slots_attributes, :day_date
  belongs_to :schedule, :autosave => true
  has_many :time_slots, :autosave => true
  validates :label,  :presence => true
  validates_date :day_date
  accepts_nested_attributes_for :time_slots

  before_save :syncTimeSlotsDate

  def syncTimeSlotsDate
  	date = Time.parse(day_date.to_s)
  	time_slots.each do |slot|
	    y = date.year
	    m = date.month
	    d = date.day
	    st = Time.parse(slot.start_time.to_s)
	    et = Time.parse(slot.end_time.to_s)
	    slot.start_time = DateTime.new(y, m, d, st.hour, st.min, st.sec)
	    slot.end_time = DateTime.new(y, m, d, et.hour, et.min, et.sec)
	end
  end
end
