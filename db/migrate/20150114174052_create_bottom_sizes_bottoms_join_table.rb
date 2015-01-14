class CreateBottomSizesBottomsJoinTable < ActiveRecord::Migration
  def change
    create_join_table :bottoms, :bottom_sizes do |t|
      t.index [:bottom_id, :bottom_size_id], name: "sizes_for_a_bottom_index"
      t.index [:bottom_size_id, :bottom_id], name: "bottoms_of_a_size_index"
    end
  end
end
