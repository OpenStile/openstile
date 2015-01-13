class AddLookReferenceToRetailers < ActiveRecord::Migration
  def change
    add_reference :retailers, :look, index: true
  end
end
