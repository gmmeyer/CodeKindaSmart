class AddCounterCaches < ActiveRecord::Migration
  def change

  	add_column :users, :notifications_count, :integer
  	add_column :users, :document_count, :integer
  	add_column :documents, :annotation_count, :integer
  	add_column :documents, :notification_count, :integer
  	add_column :authors, :document_count, :integer
  	add_column :authors, :notification_count, :integer

  end
end
