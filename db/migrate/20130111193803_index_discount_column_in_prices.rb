class IndexDiscountColumnInPrices < ActiveRecord::Migration
  def up
    rename_column(:prices, :discount_id, :discount_key)
    add_index(:prices, :discount_key)
  end

  def down
    rename_column(:prices, :discount_key, :discount_id)
    remove_index(:prices, :discount_key)
  end
end
