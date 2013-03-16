class AddMemberEmailToUsers < ActiveRecord::Migration
  def change
    add_column :users, :fax_number, :integer
    add_column :users, :ifta_member_email, :string
  end
end
