class AddPaymentMethodToTransactions < ActiveRecord::Migration
  def change
    add_column :transactions, :payment_method, :string
  end
end
