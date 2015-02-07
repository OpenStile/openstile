class AddImageToTop < ActiveRecord::Migration
  def change
    add_column :tops, :image, :string
  end
end
