class CreateAuthors < ActiveRecord::Migration
  def change
    create_table :authors do |t|
      t.string :name, null: false
      t.text :description
      t.string :location

      t.integer :user_id

      t.timestamps
    end

    add_index :authors, :user_id
    add_index :authors, :name, unique: true
  end
end
