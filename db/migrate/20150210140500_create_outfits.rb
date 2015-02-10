class CreateOutfits < ActiveRecord::Migration
  def change
    create_table :outfits do |t|
      t.string :name
      t.string :description
      t.string :price_description
      t.references :retailer, index: true
      t.references :look, index: true
      t.references :body_shape, index: true
      t.boolean :for_petite
      t.boolean :for_tall
      t.boolean :for_full_figured
      t.references :top_fit, index: true
      t.references :bottom_fit, index: true
      t.decimal :average_price

      t.timestamps
    end
  end
end
