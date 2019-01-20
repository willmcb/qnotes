class AddNameToCollections < ActiveRecord::Migration[5.2]
  def change
    add_column :collections, :name, :string
  end
end
