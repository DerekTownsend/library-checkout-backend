class AddUsersRefToLibraryItems < ActiveRecord::Migration[5.2]
  def change
    add_reference :library_items, :user, foreign_key: true
  end
end
