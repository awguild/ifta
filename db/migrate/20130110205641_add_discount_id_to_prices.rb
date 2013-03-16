class AddDiscountIdToPrices < ActiveRecord::Migration
  def change
    add_column :prices, :discount_id, :integer
  end
end
