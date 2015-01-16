class AddColorReferenceToDresses < ActiveRecord::Migration
  def change
    add_reference :dresses, :color, index: true
  end
end
