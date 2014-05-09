class AddCounterCacheToUsersForAnnotation < ActiveRecord::Migration
  def change
  	add_column :users, :annotations_count, :integer
  end
end
