class VoteCacheCounter < ActiveRecord::Migration
  def change
  	add_column :annotations, :up_votes_count, :integer
  	add_column :users, :up_votes_count, :integer
  	add_column :annotations, :down_votes_count, :integer
  	add_column :users, :down_votes_count, :integer
  end
end
