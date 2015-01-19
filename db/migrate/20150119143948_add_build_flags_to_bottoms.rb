class AddBuildFlagsToBottoms < ActiveRecord::Migration
  def change
    add_column :bottoms, :for_petite, :boolean
    add_column :bottoms, :for_tall, :boolean
    add_column :bottoms, :for_full_figured, :boolean
  end
end
