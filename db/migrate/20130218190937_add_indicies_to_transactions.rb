class AddIndiciesToTransactions < ActiveRecord::Migration
  def change
    add_index :transactions, :user_id
    add_index :transactions, :paid
    change_column :transactions, :paid, :boolean, :default => false
  end
end
