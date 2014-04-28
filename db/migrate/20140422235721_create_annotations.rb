class CreateAnnotations < ActiveRecord::Migration
  def change
    create_table :annotations do |t|
      t.string :title, null: false
      t.text :body, null: false
      t.integer :user_id, null: false

      t.integer :document_id, null: false
      t.integer :start_location, null: false
      t.integer :end_location, null: false

      t.timestamps
    end

    add_index :annotations, :title
    add_index :annotations, :user_id
    add_index :annotations, :body
    add_index :annotations, :document_id
    add_index :annotations, [:start_location, :end_location]
  end
end
