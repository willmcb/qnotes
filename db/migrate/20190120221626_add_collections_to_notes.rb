class AddCollectionsToNotes < ActiveRecord::Migration[5.2]
  def change
    add_reference :notes, :collection, foreign_key: true
  end
end
