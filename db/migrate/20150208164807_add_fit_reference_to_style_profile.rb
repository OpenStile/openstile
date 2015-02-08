class AddFitReferenceToStyleProfile < ActiveRecord::Migration
  def change
    remove_column :style_profiles, :top_fit, :string
    remove_column :style_profiles, :bottom_fit, :string
    add_reference :style_profiles, :top_fit, index: true
    add_reference :style_profiles, :bottom_fit, index: true
  end
end
