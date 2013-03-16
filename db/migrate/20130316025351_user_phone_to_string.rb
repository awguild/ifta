class UserPhoneToString < ActiveRecord::Migration
  def up
    change_column :users, :phone, :string
    change_column :users, :fax_number, :string
    change_column :presenters, :home_telephone, :string
    change_column :presenters, :work_telephone, :string
    change_column :presenters, :fax_number, :string
  end

  def down
    change_column :users, :phone, :integer
    change_column :users, :fax_number, :integer
    change_column :presenters, :home_telephone, :integer
    change_column :presenters, :work_telephone, :integer
    change_column :presenters, :fax_number, :integer
  end
end
