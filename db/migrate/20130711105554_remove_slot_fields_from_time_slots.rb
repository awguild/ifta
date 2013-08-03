class RemoveSlotFieldsFromTimeSlots < ActiveRecord::Migration
  def up
    remove_column :time_slots, :proposal_id
    remove_column :time_slots, :room_id
    remove_column :time_slots, :label
    remove_column :time_slots, :comments
    remove_column :time_slots, :quantity
  end

  def down
    add_column :time_slots, :proposal_id, :integer
    add_column :time_slots, :room_id, :integer
    add_column :time_slots, :label, :string
    add_column :time_slots, :comments, :text
    add_column :time_slots, :quantity, :integer
  end
end
