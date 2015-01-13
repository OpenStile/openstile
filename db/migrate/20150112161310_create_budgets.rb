class CreateBudgets < ActiveRecord::Migration
  def change
    create_table :budgets do |t|
      t.references :style_profile, index: true
      t.decimal :top_min_price
      t.decimal :top_max_price
      t.decimal :bottom_min_price
      t.decimal :bottom_max_price
      t.decimal :dress_min_price
      t.decimal :dress_max_price

      t.timestamps
    end
  end
end
