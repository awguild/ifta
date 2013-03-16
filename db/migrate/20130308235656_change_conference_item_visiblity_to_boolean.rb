class ChangeConferenceItemVisiblityToBoolean < ActiveRecord::Migration
  def up
    change_column :conference_items, :visibility, :boolean
  end

  def down
    change_column :conference_items, :visibility, :string
  end
end
