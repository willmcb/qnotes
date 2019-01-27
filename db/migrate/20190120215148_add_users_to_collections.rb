class AddUsersToCollections < ActiveRecord::Migration[5.2]
  def change
    add_reference :collections, :user, foreign_key: true
  end
end
