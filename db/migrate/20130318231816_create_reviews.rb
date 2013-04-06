class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :proposal_id
      t.string :status
      t.string :comments
      t.integer :reviewer_id
      t.timestamps
    end
    
    add_index :reviews, :proposal_id
    add_index :reviews, :status
  end
end
