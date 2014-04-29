class VoteCacheCounter < ActiveRecord::Migration
  def change
  	add_column :annotations, :upvote_count, :integer
  	add_column :users, :upvote_count, :integer
  	add_column :annotations, :downvote_count, :integer
  	add_column :users, :downvote_count, :integer
  end
end
