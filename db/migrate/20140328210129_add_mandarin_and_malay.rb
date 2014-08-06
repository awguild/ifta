class AddMandarinAndMalay < ActiveRecord::Migration
  def up
    add_column :proposals, :language_mandarin, :boolean
    add_column :proposals, :language_malay, :boolean
  end

  def down
    remove_column :proposals, :language_mandarin
    remove_column :proposals, :language_malay
  end
end
