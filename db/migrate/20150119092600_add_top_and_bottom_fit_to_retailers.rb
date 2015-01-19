class AddTopAndBottomFitToRetailers < ActiveRecord::Migration
  def change
    add_column :retailers, :top_fit, :string
    add_column :retailers, :bottom_fit, :string
  end
end
