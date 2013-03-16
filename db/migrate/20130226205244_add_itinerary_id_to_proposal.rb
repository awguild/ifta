class AddItineraryIdToProposal < ActiveRecord::Migration
  def change
    add_column :proposals, :itinerary_id, :integer
    add_index :proposals, :itinerary_id
  end
end
