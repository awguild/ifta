class RemoveLetterRequestFromPresenters < ActiveRecord::Migration
  def up
    remove_column :presenters, :letter_request
  end

  def down
    add_column :presenters, :letter_request, :boolean
  end
end
