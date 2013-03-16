class AddPriceCommentFieldsToConferenceItems < ActiveRecord::Migration
  def change
    add_column :conference_items, :manual_price, :boolean
    add_column :conference_items, :user_comment, :boolean
    add_column :conference_items, :user_comment_prompt, :string
  end
end
