class CreateConferences < ActiveRecord::Migration
  def change
    create_table :conferences do |t|
      t.integer :conference_year
      t.decimal :tax_rate, :precision => 10, :scale => 2, :allow_nil => false
      t.text :proposal_acceptance
      t.text :proposal_wait_list
      t.text :proposal_reject
      t.text :payment_recieved
      t.boolean :active
      t.timestamps
    end
  end
end
