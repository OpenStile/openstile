class AddImageToTop < ActiveRecord::Migration
  def change
    add_column :tops, :image_id, :string
  end
end
