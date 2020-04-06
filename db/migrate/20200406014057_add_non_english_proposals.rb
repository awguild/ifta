class AddNonEnglishProposals < ActiveRecord::Migration[6.0]
  def change
    add_column :proposals, :title_non_english, :string
    add_column :proposals, :short_description_non_english, :text
  end
end
