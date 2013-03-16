class AddDefaultFToLineItems < ActiveRecord::Migration
  def change
    change_column :line_items, :paid, :boolean, :default => false
  end
end
