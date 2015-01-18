class AddBodyShapeReferenceToRetailers < ActiveRecord::Migration
  def change
    add_reference :retailers, :body_shape, index: true
  end
end
