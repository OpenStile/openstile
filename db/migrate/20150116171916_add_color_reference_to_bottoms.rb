class AddColorReferenceToBottoms < ActiveRecord::Migration
  def change
    add_reference :bottoms, :color, index: true
  end
end
