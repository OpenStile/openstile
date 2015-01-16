class AddColorReferenceToTops < ActiveRecord::Migration
  def change
    add_reference :tops, :color, index: true
  end
end
