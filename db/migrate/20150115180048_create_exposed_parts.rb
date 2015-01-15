class CreateExposedParts < ActiveRecord::Migration
  def change
    create_table :exposed_parts do |t|
      t.references :part, index: true
      t.references :exposable, polymorphic: true, index: true

      t.timestamps
    end
  end
end
