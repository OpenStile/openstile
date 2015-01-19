class AddBodyShapeReferenceToDresses < ActiveRecord::Migration
  def change
    add_reference :dresses, :body_shape, index: true
  end
end
