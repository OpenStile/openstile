class RemoveNeighborhoodFromRetailers < ActiveRecord::Migration
  def change
    remove_column :retailers, :neighborhood, :string
  end
end
