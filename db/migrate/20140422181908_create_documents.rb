class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string :title, null: false
      t.text :summary
      t.text :body, null: false
      t.datetime :release_date

      t.integer :user_id, null: false
      t.integer :author_id, null: false

      t.timestamps
    end
    add_index :documents, :title, unique: true
    add_index :documents, :user_id
    add_index :documents, :author_id
  end
end
