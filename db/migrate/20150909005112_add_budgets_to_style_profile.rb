class AddBudgetsToStyleProfile < ActiveRecord::Migration
  def change
    add_column :style_profiles, :top_budget, :string
    add_column :style_profiles, :bottom_budget, :string
    add_column :style_profiles, :dress_budget, :string
  end
end
