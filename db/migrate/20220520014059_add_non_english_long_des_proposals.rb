class AddNonEnglishLongDesProposals < ActiveRecord::Migration[6.0]
  def change
    add_column :proposals, :long_description_non_english, :text
  end
end
