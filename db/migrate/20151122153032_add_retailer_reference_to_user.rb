class AddRetailerReferenceToUser < ActiveRecord::Migration
  def change
    add_reference :users, :retailer, index: true
  end
end
