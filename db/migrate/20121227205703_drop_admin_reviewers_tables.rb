class DropAdminReviewersTables < ActiveRecord::Migration
  def up
    drop_table :reviewers
  end

  def down
  end
end
