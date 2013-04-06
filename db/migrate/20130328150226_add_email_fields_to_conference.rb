class AddEmailFieldsToConference < ActiveRecord::Migration
  def change
    rename_column :conferences, :proposal_acceptance, :proposal_acceptance_message
    rename_column :conferences, :proposal_wait_list, :proposal_wait_list_message
    rename_column :conferences, :proposal_reject, :proposal_rejection_message
    
    add_column :conferences, :proposal_acceptance_subject, :string
    add_column :conferences, :proposal_wait_list_subject, :string
    add_column :conferences, :proposal_rejection_subject, :string 
  end
end
