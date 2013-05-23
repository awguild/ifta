class AddKeywordsToProposals < ActiveRecord::Migration
  def change
    add_column :proposals, :keywords, :string
  end
end
