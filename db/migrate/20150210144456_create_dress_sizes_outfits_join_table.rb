class CreateDressSizesOutfitsJoinTable < ActiveRecord::Migration
  def change
    create_join_table :dress_sizes, :outfits do |t|
      t.index [:dress_size_id, :outfit_id]
      t.index [:outfit_id, :dress_size_id]
    end
  end
end
