class AddLookReferenceToTops < ActiveRecord::Migration
  def change
    add_reference :tops, :look, index: true
  end
end
