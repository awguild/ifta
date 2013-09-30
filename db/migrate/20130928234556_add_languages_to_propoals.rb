class AddLanguagesToPropoals < ActiveRecord::Migration
  def change
  	add_column :proposals, :language_english, :boolean, :default => true 
  	add_column :proposals, :language_spanish, :boolean
  	add_column :proposals, :language_portuguese, :boolean
  end
end
