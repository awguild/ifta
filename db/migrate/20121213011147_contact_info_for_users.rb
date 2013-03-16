class ContactInfoForUsers < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :prefix, :string
    add_column :users, :initial, :string
    add_column :users, :suffix, :string
    add_column :users, :address, :string
    add_column :users, :city, :string
    add_column :users, :state, :string
    add_column :users, :zip, :integer
    add_column :users, :country_id, :integer
    add_column :users, :country_category, :integer
    add_column :users, :phone, :integer
    add_column :users, :username, :string
    add_column :users, :member, :boolean
    add_column :users, :student, :boolean
  end
end
