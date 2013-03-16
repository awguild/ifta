class AddMediaFieldsToProposal < ActiveRecord::Migration
  def change
    add_column :proposals, :no_equipment, :boolean
    add_column :proposals, :sound, :boolean
    add_column :proposals, :projector, :boolean
  end
end
