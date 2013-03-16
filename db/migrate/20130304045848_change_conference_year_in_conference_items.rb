class ChangeConferenceYearInConferenceItems < ActiveRecord::Migration
  def change
    rename_column :conference_items, :conference_year, :conference_id
  end

end
