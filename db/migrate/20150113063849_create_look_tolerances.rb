class CreateLookTolerances < ActiveRecord::Migration
  def change
    create_table :look_tolerances do |t|
      t.references :style_profile, index: true
      t.references :look, index: true
      t.integer :tolerance

      t.timestamps
    end
  end
end
