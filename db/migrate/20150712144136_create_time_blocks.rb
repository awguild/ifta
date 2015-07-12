class CreateTimeBlocks < ActiveRecord::Migration
  def change
    create_table :time_blocks do |t|
      t.integer :schedule_id
      t.string :code
      t.string :label
      t.datetime :start_time
      t.datetime :end_time
      t.timestamps null: false
    end

    rename_column :slots, :schedule_id, :time_block_id
    remove_column :slots, :start_time
    remove_column :slots, :end_time
  end
end
