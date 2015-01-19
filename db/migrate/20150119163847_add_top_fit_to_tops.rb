class AddTopFitToTops < ActiveRecord::Migration
  def change
    add_column :tops, :top_fit, :string
  end
end
