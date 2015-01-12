class CreateStyleProfilesTopSizesJoinTable < ActiveRecord::Migration
  def change
    create_join_table :style_profiles, :top_sizes do |t|
      t.index [:style_profile_id, :top_size_id], name: "shopper_top_sizes_index"
      t.index [:top_size_id, :style_profile_id], name: "shoppers_for_a_top_size_index"
    end
  end
end
