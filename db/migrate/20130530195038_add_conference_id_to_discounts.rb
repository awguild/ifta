class AddConferenceIdToDiscounts < ActiveRecord::Migration
  def change
    add_column :discounts, :conference_id, :integer
    add_index :discounts, :conference_id
  end
end
