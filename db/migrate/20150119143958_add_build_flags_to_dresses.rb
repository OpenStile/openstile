class AddBuildFlagsToDresses < ActiveRecord::Migration
  def change
    add_column :dresses, :for_petite, :boolean
    add_column :dresses, :for_tall, :boolean
    add_column :dresses, :for_full_figured, :boolean
  end
end
