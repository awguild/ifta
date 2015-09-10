class AddScheduleToSlots < ActiveRecord::Migration
  def up
    rename_column :slots, :time_slot_id, :schedule_id
  end

  def down
    rename_column :slots, :schedule_id, :time_slot_id
  end
end
