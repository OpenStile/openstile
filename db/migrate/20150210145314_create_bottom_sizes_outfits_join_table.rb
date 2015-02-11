class CreateBottomSizesOutfitsJoinTable < ActiveRecord::Migration
  def change
    create_join_table :outfits, :bottom_sizes do |t|
      t.index [:outfit_id, :bottom_size_id]
      t.index [:bottom_size_id, :outfit_id]
    end
  end
end
