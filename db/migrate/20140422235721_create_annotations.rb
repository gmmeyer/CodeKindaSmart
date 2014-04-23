class CreateAnnotations < ActiveRecord::Migration
  def change
    create_table :annotations do |t|
    	t.text :title, null: false
    	t.text :annotation, null: false
    	t.integer :user_id, null: false

    	t.integer :document_id, null: false
    	t.integer :start_location, null: false
    	t.integer :end_location, null: false

      t.timestamps
    end

    add_index :annotations, :user_id
    add_index :annotations, :annotation
    add_index :annotations, :document_id
    add_index :annotations, [:start_location, :end_location]
  end
end
