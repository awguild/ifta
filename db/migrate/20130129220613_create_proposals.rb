class CreateProposals < ActiveRecord::Migration
  def change
    create_table :proposals do |t|
      t.string :format
      t.string :category
      t.string :title
      t.string :short_description
      t.string :long_description
      t.boolean :student
      t.boolean :agree
      t.timestamps
    end
  end
end
