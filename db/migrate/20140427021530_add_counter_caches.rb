class AddCounterCaches < ActiveRecord::Migration
  def change

  	add_column :users, :notifications_count, :integer
  	add_column :users, :documents_count, :integer
  	add_column :documents, :annotations_count, :integer
  	add_column :documents, :notifications_count, :integer
  	add_column :authors, :documents_count, :integer
  	add_column :authors, :notifications_count, :integer

  end
end