class AddTaxFieldsToTransactions < ActiveRecord::Migration
  def change
    add_column :transactions, :pre_tax, :decimal, :precision => 10, :scale => 2
    add_column :transactions, :tax, :decimal, :precision => 10, :scale => 2
    add_column :transactions, :paid, :boolean
  end
end
