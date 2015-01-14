class CreateTopSizesTopsJoinTable < ActiveRecord::Migration
  def change
    create_join_table :tops, :top_sizes do |t|
      t.index [:top_id, :top_size_id], name: "sizes_for_a_top_index"
      t.index [:top_size_id, :top_id], name: "tops_of_a_size_index"
    end
  end
end
