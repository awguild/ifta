class AddConferenceToProposal < ActiveRecord::Migration
  def change
    add_column :proposals, :conference_id, :integer
    add_index :proposals, :conference_id
  end
end
