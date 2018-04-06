class ProposalQualifications < ActiveRecord::Migration
  def change
    add_column :presenters, :highest_degree, :string
    add_column :presenters, :graduating_institution, :string
    add_column :presenters, :qualifications, :text
    add_column :proposals, :learning_objective, :text
  end
end
