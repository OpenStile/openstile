class AddImageToDress < ActiveRecord::Migration
  def change
    add_column :dresses, :image_id, :string
  end
end
