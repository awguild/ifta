class CreatePresenters < ActiveRecord::Migration
  def change
    create_table :presenters do |t|
      t.string :first_name
      t.string :last_name
      t.integer :home_telephone
      t.integer :work_telephone
      t.integer :fax_number
      t.string :email
      t.string :affiliation_name
      t.string :affiliation_position
      t.string :affiliation_location
      t.boolean :letter_request
      t.boolean :registered
      t.integer :proposal_id
      t.timestamps
    end
  end
end
