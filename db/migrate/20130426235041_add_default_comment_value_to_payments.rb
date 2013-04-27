class AddDefaultCommentValueToPayments < ActiveRecord::Migration
  def change
    change_column :payments, :comments, :string, :default => ""
  end
end
