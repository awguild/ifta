class RenameSlots < ActiveRecord::Migration
  def up
    rename_table :slots, :time_slots
  end

  def down
    rename_table :time_slots, :slots
  end
end
