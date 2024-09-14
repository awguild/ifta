class ChangeCharset < ActiveRecord::Migration[6.0]
  def change
    execute <<-SQL
      ALTER TABLE presenters MODIFY COLUMN first_name VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
      ALTER TABLE presenters MODIFY COLUMN last_name VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
      ALTER TABLE presenters MODIFY COLUMN email VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
      ALTER TABLE presenters MODIFY COLUMN affiliation_name VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
      ALTER TABLE users MODIFY COLUMN first_name VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
      ALTER TABLE users MODIFY COLUMN last_name VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
      ALTER TABLE proposals MODIFY COLUMN title text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
      ALTER TABLE proposals MODIFY COLUMN title_non_english text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
      ALTER TABLE proposals MODIFY COLUMN short_description text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
      ALTER TABLE proposals MODIFY COLUMN long_description text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
      ALTER TABLE proposals MODIFY COLUMN keywords VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
      ALTER TABLE proposals MODIFY COLUMN short_description_non_english text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
      ALTER TABLE proposals MODIFY COLUMN long_description_non_english text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
    SQL
  end
end
