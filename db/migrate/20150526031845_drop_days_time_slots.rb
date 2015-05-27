class DropDaysTimeSlots < ActiveRecord::Migration
  def up
    drop_table :time_slots
    drop_table :days
  end

  def down
  end
end
