class FixCountryCategoryNameInPrices < ActiveRecord::Migration
  def up
    rename_column :prices, :country_category_id, :country_category
  end

  def down
    rename_column :prices, :country_category, :country_category_id
  end
end
