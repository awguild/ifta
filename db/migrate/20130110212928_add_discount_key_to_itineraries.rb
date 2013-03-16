class AddDiscountKeyToItineraries < ActiveRecord::Migration
  def change
    add_column :itineraries, :discount_key, :string
  end
end
