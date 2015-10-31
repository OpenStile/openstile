class AddStatusToRecommendations < ActiveRecord::Migration
  def change
    add_column :retailers, :status, :integer

    Retailer.reset_column_information
    Retailer.update_all(status: 1)
  end
end
