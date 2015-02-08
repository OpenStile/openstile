class AddImageToRetailer < ActiveRecord::Migration
  def change
    add_column :retailers, :image_id :string
  end
end
