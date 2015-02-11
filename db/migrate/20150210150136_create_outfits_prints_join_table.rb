class CreateOutfitsPrintsJoinTable < ActiveRecord::Migration
  def change
    create_join_table :outfits, :prints do |t|
      t.index [:outfit_id, :print_id]
      t.index [:print_id, :outfit_id]
    end
  end
end
