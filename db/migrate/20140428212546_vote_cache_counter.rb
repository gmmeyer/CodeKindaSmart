class VoteCacheCounter < ActiveRecord::Migration
  def change
  	add_column :annotations, :votes_count, :integer
  	add_column :users, :votes_count, :integer
  end
end
