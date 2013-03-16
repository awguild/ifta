class RemovePaidFromLineItems < ActiveRecord::Migration
  def up
    remove_column :line_items, :paid
  end

  def down
    add_column :line_items, :paid, :boolean
  end
end
