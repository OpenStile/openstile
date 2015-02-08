class AddTopFitReferenceToRetailer < ActiveRecord::Migration
  def change
    remove_column :retailers, :top_fit, :string
    remove_column :retailers, :bottom_fit, :string
    add_reference :retailers, :top_fit, index: true
    add_reference :retailers, :bottom_fit, index: true
  end
end
