class AddItineraryIdToTransactions < ActiveRecord::Migration
  def change
    rename_column :transactions, :user_id, :itinerary_id
  end
end
