class CreateItineraries < ActiveRecord::Migration
  def change
    create_table :itineraries do |t|
      t.integer :conference_year
      t.integer :user_id
      t.timestamps
    end
  end
end
