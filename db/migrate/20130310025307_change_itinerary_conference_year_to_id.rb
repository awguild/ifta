class ChangeItineraryConferenceYearToId < ActiveRecord::Migration
  def up
    rename_column :itineraries, :conference_year, :conference_id
  end

  def down
    rename_column :itineraries, :conference_id, :conference_year
  end
end
