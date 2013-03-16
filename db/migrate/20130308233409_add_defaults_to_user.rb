class AddDefaultsToUser < ActiveRecord::Migration
  def change
    change_column :users, :member, :boolean, :default => false
    change_column :users, :student, :boolean, :default => false
  end
end
