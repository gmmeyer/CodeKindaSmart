class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.text :title, null: false
      t.text :summary
      t.text :document, null: false
      t.text :author
      t.datetime :release_date
      t.integer :user_id, null: false

      t.timestamps
    end
    add_index :documents, :document
    add_index :documents, :title, unique: true
  end
end
