class CreateTopFits < ActiveRecord::Migration
  def change
    create_table :top_fits do |t|
      t.string :name

      t.timestamps
    end
  end
end
