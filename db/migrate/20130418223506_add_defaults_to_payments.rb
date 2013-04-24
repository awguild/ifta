class AddDefaultsToPayments < ActiveRecord::Migration
  def change
    change_column :payments, :amount, :integer, :default => 0
    add_column :payments, :comments, :string
  end
end
