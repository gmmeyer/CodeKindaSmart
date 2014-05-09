class CreateRanking < ActiveRecord::Migration
  def change

  	add_column :documents, :rank, :integer
  	add_column :users, :rank, :integer
  	add_column :annotations, :rank, :integer

  end
end
