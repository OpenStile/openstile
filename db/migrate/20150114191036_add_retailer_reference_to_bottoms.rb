class AddRetailerReferenceToBottoms < ActiveRecord::Migration
  def change
    add_reference :bottoms, :retailer, index: true
  end
end
