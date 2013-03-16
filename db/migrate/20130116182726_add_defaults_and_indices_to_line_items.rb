class AddDefaultsAndIndicesToLineItems < ActiveRecord::Migration
  def up
    change_column :line_items, :paid, :boolean, :default => false
    add_index :line_items, :conference_item_id
    add_index :line_items, :itinerary_id
    add_index :line_items, :transaction_id
    add_index :line_items, :paid
  end
end
