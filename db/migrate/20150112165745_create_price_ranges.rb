class CreatePriceRanges < ActiveRecord::Migration
  def change
    create_table :price_ranges do |t|
      t.references :retailer, index: true
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
