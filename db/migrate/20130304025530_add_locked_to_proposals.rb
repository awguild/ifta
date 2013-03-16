class AddLockedToProposals < ActiveRecord::Migration
  def change
    add_column :proposals, :locked, :boolean, :default => false
  end
end
