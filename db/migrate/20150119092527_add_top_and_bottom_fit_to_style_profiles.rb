class AddTopAndBottomFitToStyleProfiles < ActiveRecord::Migration
  def change
    add_column :style_profiles, :top_fit, :string
    add_column :style_profiles, :bottom_fit, :string
  end
end
