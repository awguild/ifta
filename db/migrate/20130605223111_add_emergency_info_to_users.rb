class AddEmergencyInfoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :emergency_name, :string
    add_column :users, :emergency_relationship, :string
    add_column :users, :emergency_telephone, :string
    add_column :users, :emergency_email, :string
  end
end
