class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :user_id, null: false
      t.integer :annotation_id, null: false
      t.integer :downvote
      t.integer :upvote

      t.timestamps
    end

    add_index :votes, :user_id
    add_index :votes, :annotation_id
    add_index :votes, :upvote
    add_index :votes, :downvote
  end
end
