class CreateRetailers < ActiveRecord::Migration
  def change
    create_table :retailers do |t|
      t.string :name
      t.string :description
      t.string :neighborhood
      t.string :size_range
      t.integer :price_index

      t.timestamps
    end
  end
end
