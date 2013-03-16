class AddStringDeafultsForUsersNames < ActiveRecord::Migration
  def up
    change_column :users, :first_name, :string, :default => ""
    change_column :users, :last_name, :string, :default => ""
  end

  def down
    change_column :users, :first_name, :string
    change_column :users, :last_name, :string
  end
end
