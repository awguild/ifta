class TimeSlot < ActiveRecord::Base
  attr_accessible :start_time, :end_time, :code, :quantity
  belongs_to :day, :autosave => true
  has_many :slots
  
  attr_accessor :quantity
  after_save :build_slots, :unless => "quantity.nil?"
  
  
  private
  def build_slots
    self.quantity.to_i.times do |n|
      self.slots.create
    end   
  end
end
