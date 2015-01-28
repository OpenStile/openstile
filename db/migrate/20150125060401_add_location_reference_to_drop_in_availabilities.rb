class AddLocationReferenceToDropInAvailabilities < ActiveRecord::Migration
  def change
    add_reference :drop_in_availabilities, :location, index: true
  end
end
