class CreateOutfitsSpecialConsiderationsJoinTable < ActiveRecord::Migration
  def change
    create_join_table :outfits, :special_considerations do |t|
      t.index [:outfit_id, :special_consideration_id], name: "special_considerations_for_outfit_index"
      t.index [:special_consideration_id, :outfit_id], name: "outfits_for_special_consideration_index"
    end
  end
end
