class AddAVtoRooms < ActiveRecord::Migration
  def up
    add_column :rooms, :audio, :boolean
    add_column :rooms, :video, :boolean
  end

  def down
    remove_column :rooms, :audio, :boolean
    remove_column :rooms, :video, :boolean
  end
end
