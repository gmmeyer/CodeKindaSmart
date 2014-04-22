class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.text :document

      t.timestamps
    end
    add_index :documents, :document
  end
end
