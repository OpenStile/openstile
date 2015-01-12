class AddCategoryToBottomSizes < ActiveRecord::Migration
  def change
    add_column :bottom_sizes, :category, :string
  end
end
