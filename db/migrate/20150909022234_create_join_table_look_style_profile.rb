class CreateJoinTableLookStyleProfile < ActiveRecord::Migration
  def change
    create_join_table :looks, :style_profiles do |t|
      t.index [:look_id, :style_profile_id]
      t.index [:style_profile_id, :look_id]
    end
  end
end
