class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.integer :schedule_id
      t.string :label
      t.timestamps
    end
  end
end
