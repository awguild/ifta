class AddTimesToSlots < ActiveRecord::Migration
  def change
    add_column :slots, :start_time, :time
    add_column :slots, :end_time, :time
    add_column :slots, :code, :string
    add_column :slots, :quantity, :integer
  end
end
