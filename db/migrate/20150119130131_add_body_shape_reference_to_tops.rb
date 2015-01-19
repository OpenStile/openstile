class AddBodyShapeReferenceToTops < ActiveRecord::Migration
  def change
    add_reference :tops, :body_shape, index: true
  end
end
