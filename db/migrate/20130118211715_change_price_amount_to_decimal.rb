class ChangePriceAmountToDecimal < ActiveRecord::Migration
  def up
    change_column :prices, :amount, :decimal, :precision => 10, :scale => 2
  end

  def down
    change_column :prices, :amount, :integer
  end
end
