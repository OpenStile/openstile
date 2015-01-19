class CreateSpecialConsiderationsStyleProfilesJoinTable < ActiveRecord::Migration
  def change
    create_join_table :special_considerations, :style_profiles do |t|
      t.index [:special_consideration_id, :style_profile_id], name: "style_profiles_for_a_special_consideration_index"
      t.index [:style_profile_id, :special_consideration_id], name: "special_consideration_for_style_profile_index"
    end
  end
end
