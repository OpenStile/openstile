class AddAboveFoldImageToRetailer < ActiveRecord::Migration
  def change
    add_column :retailers, :above_fold_image, :string
  end
end
