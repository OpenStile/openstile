class CreateJoinTableBodyBuildStyleProfile < ActiveRecord::Migration
  def change
    create_join_table :body_builds, :style_profiles do |t|
      t.index [:body_build_id, :style_profile_id], name: 'index_profiles_for_a_body_build'
      t.index [:style_profile_id, :body_build_id], name: 'index_builds_for_a_profile'
    end
  end
end
