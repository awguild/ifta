class AddAdditionalProposalsToPresenters < ActiveRecord::Migration
  def change
    add_column :presenters, :other_presentations, :boolean
    add_column :presenters, :other_emails, :string
  end
end
