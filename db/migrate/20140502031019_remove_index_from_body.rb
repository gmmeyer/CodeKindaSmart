class RemoveIndexFromBody < ActiveRecord::Migration
  def change
  	remove_index :documents, :body
  end
end
