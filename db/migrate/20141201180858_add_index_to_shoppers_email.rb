class AddIndexToShoppersEmail < ActiveRecord::Migration
  def change
    add_index :shoppers, :email, unique: true
  end
end
