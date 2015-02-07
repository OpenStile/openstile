class AddImageToDress < ActiveRecord::Migration
  def change
    add_column :dresses, :image, :string
  end
end
