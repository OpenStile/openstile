class CreatePartExposureTolerances < ActiveRecord::Migration
  def change
    create_table :part_exposure_tolerances do |t|
      t.references :part, index: true
      t.references :style_profile, index: true
      t.integer :tolerance

      t.timestamps
    end
  end
end
