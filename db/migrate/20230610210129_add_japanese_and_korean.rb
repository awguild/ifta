class AddJapaneseAndKorean < ActiveRecord::Migration[6.0]
    def up
      add_column :proposals, :language_japanese, :boolean, after: :language_mandarin
      add_column :proposals, :language_korean, :boolean, after: :language_japanese
    end

    def down
      remove_column :proposals, :language_japanese
      remove_column :proposals, :language_korean
    end
  end

