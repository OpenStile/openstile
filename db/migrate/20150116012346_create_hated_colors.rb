class CreateHatedColors < ActiveRecord::Migration
  def change
    create_table :hated_colors do |t|
      t.references :style_profile, index: true
      t.references :color, index: true

      t.timestamps
    end
  end
end
