class CreateStyleProfilesBottomSizesJoinTable < ActiveRecord::Migration
  def change
    create_join_table :style_profiles, :bottom_sizes do |t|
      t.index [:style_profile_id, :bottom_size_id], name: "shopper_bottom_sizes_index"
      t.index [:bottom_size_id, :style_profile_id], name: "shoppers_for_a_bottom_size_index"
    end
  end
end
