class CreatePartsToFlaunt < ActiveRecord::Migration
  def change
    create_table :parts_to_flaunts do |t|
      t.references :part, index: true
      t.references :style_profile, index: true
    end
  end
end
