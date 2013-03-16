class CreateCountryCategories < ActiveRecord::Migration
  def change
    create_table :country_categories do |t|
      t.string :name
      t.integer :category
    end
  end
end
