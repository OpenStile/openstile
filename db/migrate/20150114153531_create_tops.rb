class CreateTops < ActiveRecord::Migration
  def change
    create_table :tops do |t|
      t.string :name
      t.string :description
      t.string :web_link
      t.decimal :price

      t.timestamps
    end
  end
end
