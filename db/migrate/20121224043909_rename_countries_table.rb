class RenameCountriesTable < ActiveRecord::Migration
  def self.up
    rename_table :country_categories, :countries
  end

 def self.down
    rename_table :countries, :country_categories
 end
end

