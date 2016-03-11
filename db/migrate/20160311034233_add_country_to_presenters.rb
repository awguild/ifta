class AddCountryToPresenters < ActiveRecord::Migration
  def change
    add_column :presenters, :country_id, :integer
    add_index :presenters, :country_id
  end
end
