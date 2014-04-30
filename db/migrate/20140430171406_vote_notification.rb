class VoteNotification < ActiveRecord::Migration
  def change
  	add_column :votes, :notifications_count, :integer
  end
end
