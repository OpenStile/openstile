class AddImageToRetailer < ActiveRecord::Migration
  def change
    add_column :retailers, :image, :string
  end
end
