class AddBottomFitToBottoms < ActiveRecord::Migration
  def change
    add_column :bottoms, :bottom_fit, :string
  end
end
