class AddRelativeNumberToProposals < ActiveRecord::Migration
  def change
    add_column :proposals, :relative_number, :integer
  end
end
