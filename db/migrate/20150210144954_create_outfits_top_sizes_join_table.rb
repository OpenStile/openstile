class CreateOutfitsTopSizesJoinTable < ActiveRecord::Migration
  def change
    create_join_table :outfits, :top_sizes do |t|
      t.index [:outfit_id, :top_size_id]
      t.index [:top_size_id, :outfit_id]
    end
  end
end
