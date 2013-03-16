class CreatePrices < ActiveRecord::Migration
  def change
    create_table :prices do |t|
      t.integer :conference_item_id
      t.integer :country_category_id
      t.integer :amount
      t.timestamps
    end
  end
end
