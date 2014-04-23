class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.text :title, null: false
      t.text :summary
      t.text :body, null: false
      t.text :author
      t.datetime :release_date
      t.integer :user_id, null: false

      t.timestamps
    end
    
    add_index :documents, :body
    add_index :documents, :title, unique: true
    add_index :documents, :user_id
    add_index :documents, :author
  end
end
