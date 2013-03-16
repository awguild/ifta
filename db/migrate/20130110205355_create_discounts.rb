class CreateDiscounts < ActiveRecord::Migration
  def change
    create_table :discounts do |t|
      t.string :discount_key
      t.string :description
      t.timestamps
    end
  end
end
