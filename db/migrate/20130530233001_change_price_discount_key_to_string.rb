class ChangePriceDiscountKeyToString < ActiveRecord::Migration
  def up
    change_column :prices, :discount_key, :string
  end

  def down
    change_column :prices, :discount_key, :integer
  end
end
