class AddFitReferenceToTops < ActiveRecord::Migration
  def change
    remove_column :tops, :top_fit, :string
    add_reference :tops, :top_fit, index: true
  end
end
