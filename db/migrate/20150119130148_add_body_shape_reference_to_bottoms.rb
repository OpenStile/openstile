class AddBodyShapeReferenceToBottoms < ActiveRecord::Migration
  def change
    add_reference :bottoms, :body_shape, index: true
  end
end
