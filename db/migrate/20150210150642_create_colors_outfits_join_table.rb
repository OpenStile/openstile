class CreateColorsOutfitsJoinTable < ActiveRecord::Migration
  def change
    create_join_table :outfits, :colors do |t|
      t.index [:outfit_id, :color_id]
      t.index [:color_id, :outfit_id]
    end
  end
end
