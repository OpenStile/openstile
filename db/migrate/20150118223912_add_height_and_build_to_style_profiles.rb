class AddHeightAndBuildToStyleProfiles < ActiveRecord::Migration
  def change
    add_column :style_profiles, :height_feet, :integer
    add_column :style_profiles, :height_inches, :integer
    add_column :style_profiles, :body_build, :string
  end
end
