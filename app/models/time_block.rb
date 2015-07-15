class TimeBlock < ActiveRecord::Base
  has_many :slots, dependent: :destroy
  belongs_to :room
  belongs_to :proposal
  belongs_to :schedule

  validates_datetime :start_time
  validates_datetime :end_time

  after_create :create_slots

  private

  # for each of the existing rooms create a slot for the time block / room
  def create_slots
    schedule.rooms.each do |room|
      room.slots.create!({time_block_id: id})
    end
  end
end
