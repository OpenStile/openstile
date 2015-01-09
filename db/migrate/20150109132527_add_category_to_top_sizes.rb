class AddCategoryToTopSizes < ActiveRecord::Migration
  def change
    add_column :top_sizes, :category, :string
  end
end
