class RemoveDaysAndTimeSlots < ActiveRecord::Migration
  def change
    drop_table :days
    drop_table :time_slots
  end
end
