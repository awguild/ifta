class TimeSlot < ActiveRecord::Base
  attr_accessible :start_time, :end_time, :code, :quantity
  accepts_nested_attributes_for :slots, :allow_destroy => true

  #associations
  has_many :slots, :dependent => :destroy
  belongs_to :day, :autosave => true

  #validations
  validates_datetime :end_time
  validates_datetime :start_time
  validates_datetime :end_time, :after => :start_time

  #life cycle hooks  
  after_save :build_slots
  before_validation :parseTimes
  

  attr_accessor :quantity
  private

  def build_slots
    self.quantity = 0 if self.quantity.nil?
    self.quantity.to_i.times do |n|
      self.slots.create
    end
    self.quantity = 0
  end

  def parseTimes
    self.start_time = Time.parse(self.start_time.to_s).to_s unless self.start_time.nil?
    self.end_time = Time.parse(self.end_time.to_s).to_s unless self.start_time.nil?
  end


end
