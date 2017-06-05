class AddThaiToLanguages < ActiveRecord::Migration
  def change
    add_column :proposals, :language_thai, :bool
  end
end
