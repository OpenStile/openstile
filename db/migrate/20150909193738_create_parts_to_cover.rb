class CreatePartsToCover < ActiveRecord::Migration
  def change
    create_table :parts_to_covers do |t|
      t.references :part, index: true
      t.references :style_profile, index: true
    end
  end
end
