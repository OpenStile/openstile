class AddRetailerReferenceToDresses < ActiveRecord::Migration
  def change
    add_reference :dresses, :retailer, index: true
  end
end
