class AddToDocument < ActiveRecord::Migration
  def change
    remove_column :documents, :author
    add_column :documents, :author_id, :integer
    add_index :documents, :author_id
  end
end
