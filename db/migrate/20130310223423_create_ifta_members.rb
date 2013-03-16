class CreateIftaMembers < ActiveRecord::Migration
  def change
    create_table :ifta_members do |t|
      t.string :email
    end
  end
end
