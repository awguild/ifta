class DropSchedulingTables < ActiveRecord::Migration[6.0]
  def up
    drop_table :slots
    drop_table :rooms
    drop_table :time_blocks
    drop_table :schedules
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
