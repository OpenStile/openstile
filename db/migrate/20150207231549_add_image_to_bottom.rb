class AddImageToBottom < ActiveRecord::Migration
  def change
    add_column :bottoms, :image_id, :string
  end
end
