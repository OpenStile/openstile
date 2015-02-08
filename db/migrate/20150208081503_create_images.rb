class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :name
      t.string :url
      t.string :height
      t.string :width
      t.string :format
      t.string :retailer_id
      t.string :dress_id
      t.string :top_id
      t.string :bottom_id

      t.timestamps
    end
  end
end
