class AddCategoryToDressSizes < ActiveRecord::Migration
  def change
    add_column :dress_sizes, :category, :string
  end
end
