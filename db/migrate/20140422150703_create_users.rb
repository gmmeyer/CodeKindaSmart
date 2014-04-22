class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.text :username, null: false
      t.text :email, null: false
      t.text :password_digest, null: false
      t.text :session_token

      t.timestamps
    end
    add_index :users, :session_token
    add_index :users, :username, unique: true
    add_index :users, [:username, :password_digest]
    add_index :users, :email
  end
end
