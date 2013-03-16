class AddVisibilityToConferenceItems < ActiveRecord::Migration
  def change
    add_column :conference_items, :visibility, :string
  end
end
