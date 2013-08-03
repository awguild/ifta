class AddDateToDays < ActiveRecord::Migration
  def change
   add_column :days, :day_date, :date
  end
end
