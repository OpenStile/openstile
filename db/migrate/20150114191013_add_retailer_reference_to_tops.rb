class AddRetailerReferenceToTops < ActiveRecord::Migration
  def change
    add_reference :tops, :retailer, index: true
  end
end
