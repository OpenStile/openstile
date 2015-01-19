class AddFitToDresses < ActiveRecord::Migration
  def change
    add_column :dresses, :top_fit, :string
    add_column :dresses, :bottom_fit, :string
  end
end
