class AddBuildFlagsToTops < ActiveRecord::Migration
  def change
    add_column :tops, :for_petite, :boolean
    add_column :tops, :for_tall, :boolean
    add_column :tops, :for_full_figured, :boolean
  end
end
