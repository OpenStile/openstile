class AddLookReferenceToBottoms < ActiveRecord::Migration
  def change
    add_reference :bottoms, :look, index: true
  end
end
