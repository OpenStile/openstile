class AddPetiteFullFiguredFlagsToRetailers < ActiveRecord::Migration
  def change
    add_column :retailers, :for_petite, :boolean
    add_column :retailers, :for_tall, :boolean
    add_column :retailers, :for_full_figured, :boolean
  end
end
