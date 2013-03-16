class AddUntaxedToLineItem < ActiveRecord::Migration
  def change
    add_column :line_items, :untaxed, :boolean, :default => false
    add_column :line_items, :comment, :string
    change_column :line_items, :price, :decimal, :precision => 10, :scale => 2
  end
end
