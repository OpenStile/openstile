class AddImageToBottom < ActiveRecord::Migration
  def change
    add_column :bottoms, :image, :string
  end
end
