class AddPaidToLineItems < ActiveRecord::Migration
  def change
    add_column :line_items, :paid, :boolean
  end
end
