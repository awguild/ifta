class AddIndexToMembersEmail < ActiveRecord::Migration
  def change
    add_index :ifta_members, :email, :unique => true
  end
end
