class AddPayPalFieldsToPayments < ActiveRecord::Migration
  def change
    add_column :payments, :params, :text
    add_column :payments, :confirmed, :boolean
  end
end
