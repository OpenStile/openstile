class CreateStyleProfilesDressSizesJoinTable < ActiveRecord::Migration
  def change
    create_join_table :style_profiles, :dress_sizes do |t|
      t.index [:style_profile_id, :dress_size_id], name: "shopper_dress_sizes_index"
      t.index [:dress_size_id, :style_profile_id], name: "shoppers_for_a_dress_size_index"
    end
  end
end
