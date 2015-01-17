class AddNametagToUsers < ActiveRecord::Migration
  def change
    add_column :users, :nametag_name, :string
    add_column :users, :certificate_name, :string
  end
end
