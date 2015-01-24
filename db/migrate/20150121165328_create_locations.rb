class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.references :locatable, polymorphic: true, index: true
      t.string :address
      t.string :short_title

      t.timestamps
    end
  end
end
