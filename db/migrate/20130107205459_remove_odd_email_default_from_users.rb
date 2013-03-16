class RemoveOddEmailDefaultFromUsers < ActiveRecord::Migration
  def up
    change_column_default(:users, :email, "")
    change_column_default(:users, :encrypted_password, "")
  end

  def down
    change_column_default(:users, :email, "'")
    change_column_default(:users, :encrypted_password, "'")
  end
end
