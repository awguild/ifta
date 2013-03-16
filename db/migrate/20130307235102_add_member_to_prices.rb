class AddMemberToPrices < ActiveRecord::Migration
  def change
    add_column :prices, :member, :boolean
    
    add_index :prices, :conference_item_id
    add_index :prices, :country_category
    add_index :prices, :member
  end
end
