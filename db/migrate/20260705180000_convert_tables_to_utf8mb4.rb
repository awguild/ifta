class ConvertTablesToUtf8mb4 < ActiveRecord::Migration[6.0]
  def up
    execute "ALTER TABLE presenters CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
    execute "ALTER TABLE proposals CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
    execute "ALTER TABLE users CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
    execute "ALTER TABLE versions CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
  end

  def down
    raise ActiveRecord::IrreversibleMigration, "converting back to latin1 could truncate or corrupt non-latin1 data already stored"
  end
end
