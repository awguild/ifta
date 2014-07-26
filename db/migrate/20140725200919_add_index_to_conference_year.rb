class AddIndexToConferenceYear < ActiveRecord::Migration
  def change
    add_index :conferences, :conference_year
  end
end
