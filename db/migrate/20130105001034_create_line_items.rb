class CreateLineItems < ActiveRecord::Migration
  def change
    create_table :line_items do |t|
      t.integer :conference_item_id
      t.integer :itinerary_id
      t.integer :transaction_id
      t.integer :price
      t.boolean :paid
      t.timestamps
    end
  end
end
