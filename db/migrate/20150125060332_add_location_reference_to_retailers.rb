class AddLocationReferenceToRetailers < ActiveRecord::Migration
  def change
    add_reference :retailers, :location, index: true
  end
end
