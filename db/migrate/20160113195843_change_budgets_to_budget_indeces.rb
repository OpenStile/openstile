class ChangeBudgetsToBudgetIndeces < ActiveRecord::Migration
  def up
    existing_budgets = []
    existing_budget_text_mapping = {'max $50'=> 1, 'max $100'=> 2, 'max $150'=> 3, 'max $200'=> 4, '$200 +'=> 5}

    StyleProfile.all.each do |profile|
      existing_budgets << {id: profile.id,
                           top_budget: existing_budget_text_mapping[profile.top_budget] || 1,
                           bottom_budget: existing_budget_text_mapping[profile.bottom_budget] || 1,
                           dress_budget: existing_budget_text_mapping[profile.dress_budget] || 1}
    end

    add_column :style_profiles, :top_budget_index, :integer
    add_column :style_profiles, :bottom_budget_index, :integer
    add_column :style_profiles, :dress_budget_index, :integer
    remove_column :style_profiles, :top_budget, :string
    remove_column :style_profiles, :bottom_budget, :string
    remove_column :style_profiles, :dress_budget, :string

    StyleProfile.reset_column_information

    existing_budgets.each do |budget|
      StyleProfile.find(budget[:id]).update_attributes!(top_budget_index: budget[:top_budget],
                                             bottom_budget_index: budget[:bottom_budget],
                                             dress_budget_index: budget[:dress_budget])
    end
  end

  def down
    remove_column :style_profiles, :top_budget_index, :integer
    remove_column :style_profiles, :bottom_budget_index, :integer
    remove_column :style_profiles, :dress_budget_index, :integer
    add_column :style_profiles, :top_budget, :string
    add_column :style_profiles, :bottom_budget, :string
    add_column :style_profiles, :dress_budget, :string
  end
end
