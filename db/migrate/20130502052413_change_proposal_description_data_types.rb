class ChangeProposalDescriptionDataTypes < ActiveRecord::Migration
  def up
    change_column :proposals, :short_description, :text
    change_column :proposals, :long_description, :text
  end

  def down
    change_column :proposals, :short_description, :string
    change_column :proposals, :long_description, :string
  end
end
