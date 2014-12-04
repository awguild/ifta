class PresentationFields < ActiveRecord::Migration
  def up
    add_column :proposals, :date_accepted, :datetime
    add_column :proposals, :date_emailed, :datetime
    add_column :proposals, :invite_letter, :datetime
    add_column :proposals, :notes, :text
  end

  def down
    drop_column :proposals, :date_accepted, :datetime
    drop_column :proposals, :date_emailed, :datetime
    drop_column :proposals, :invite_letter, :datetime
    drop_column :proposals, :notes, :text
  end
end
