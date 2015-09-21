class CreateColorsToAvoid < ActiveRecord::Migration
  def change
    create_table :colors_to_avoids do |t|
      t.references :color, index: true
      t.references :style_profile, index: true
    end
  end
end
