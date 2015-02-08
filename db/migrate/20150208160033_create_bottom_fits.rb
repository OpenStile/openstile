class CreateBottomFits < ActiveRecord::Migration
  def change
    create_table :bottom_fits do |t|
      t.string :name

      t.timestamps
    end
  end
end
