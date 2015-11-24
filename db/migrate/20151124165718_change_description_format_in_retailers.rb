class ChangeDescriptionFormatInRetailers < ActiveRecord::Migration
  def change
    change_column :retailers, :description, :text
  end
end
