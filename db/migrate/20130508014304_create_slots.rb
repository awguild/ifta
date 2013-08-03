class CreateSlots < ActiveRecord::Migration
  def change
    create_table :slots do |t|
      t.integer :proposal_id
      t.integer :day_id
      t.integer :room_id
      t.string :label
      t.string :comments
      t.timestamps
    end
  end
end
