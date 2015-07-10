class AddStartEndToSlots < ActiveRecord::Migration
  def change
    add_column :slots, :start_time, :time
    add_column :slots, :end_time, :time
  end
end
