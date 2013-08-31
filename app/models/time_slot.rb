class TimeSlot < ActiveRecord::Base
  attr_accessible :start_time, :end_time, :code, :quantity
  belongs_to :day, :autosave => true
  has_many :slots
  validates_datetime :end_time
  validates_datetime :start_time
  validates_datetime :end_time, :after => :start_time
  
  attr_accessor :quantity
  after_save :build_slots, :unless => "quantity.nil?"
  before_validation :parseTimes
  
  private
  def build_slots
    self.quantity.to_i.times do |n|
      self.slots.create
    end   
  end

  def parseTimes
    start_time = Time.parse(start_time) unless start_time.nil?
    end_time = Time.parse(end_time) unless start_time.nil?
  end


end
