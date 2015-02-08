class AddFitReferenceToBottoms < ActiveRecord::Migration
  def change
    remove_column :bottoms, :bottom_fit, :string
    add_reference :bottoms, :bottom_fit, index: true
  end
end
