class Room < ActiveRecord::Base
  has_many :proposals
  belongs_to :schedule
  has_one :conference, :through => :schedule
  has_many :slots, :dependent => :destroy

  validates :schedule, presence: true

  after_create :create_slots

  # for each of the existing time blocks create a slot for the time block / room
  def create_slots
    schedule.time_blocks.each do |time_block|
      time_block.slots.create!({room_id: id})
    end
  end
end
