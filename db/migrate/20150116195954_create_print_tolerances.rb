class CreatePrintTolerances < ActiveRecord::Migration
  def change
    create_table :print_tolerances do |t|
      t.references :style_profile, index: true
      t.references :print, index: true
      t.integer :tolerance

      t.timestamps
    end
  end
end
