class AddUserToProposals < ActiveRecord::Migration
  def change
    add_column :proposals, :user_id, :integer
    add_index :proposals, :user_id
  end
end
