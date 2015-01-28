class RemoveLocatableReferenceFromLocations < ActiveRecord::Migration
  def change
    remove_reference :locations, :locatable, polymorphic: true, index: true
  end
end
