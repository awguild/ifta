class CreateConferenceItems < ActiveRecord::Migration
  def change
    create_table :conference_items do |t|
      t.string :name
      t.string :description
      t.boolean :multiple , :default => false
      t.integer :max
      t.integer :conference_year
      t.timestamps
    end
  end
end
