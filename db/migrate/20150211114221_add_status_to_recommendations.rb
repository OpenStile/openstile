class AddStatusToRecommendations < ActiveRecord::Migration
  def change
    add_column :retailers, :status, :integer
    add_column :outfits, :status, :integer
    add_column :tops, :status, :integer
    add_column :bottoms, :status, :integer
    add_column :dresses, :status, :integer

    Retailer.reset_column_information
    Retailer.update_all(status: 1)
    Outfit.reset_column_information
    Outfit.update_all(status: 1)
    Top.reset_column_information
    Top.update_all(status: 1)
    Bottom.reset_column_information
    Bottom.update_all(status: 1)
    Dress.reset_column_information
    Dress.update_all(status: 1)
  end
end
