class RemovePreTaxFromTransactions < ActiveRecord::Migration
  def up
    remove_column :transactions, :pre_tax
  end

  def down
    add_column :transactons, :pre_tax, :decimal, {:precision => 10, :scale => 2}
  end
end
