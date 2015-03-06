class CreateFavorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.references :shopper, index: true
      t.references :favoriteable, polymorphic: true, index: true

      t.timestamps

      t.index [:shopper_id, :favoriteable_id, :favoriteable_type], unique: true, name: "index_unique_shopper_favorites"
    end
  end
end
