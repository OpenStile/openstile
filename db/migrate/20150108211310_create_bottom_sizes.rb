class CreateBottomSizes < ActiveRecord::Migration
  def change
    create_table :bottom_sizes do |t|
      t.string :name

      t.timestamps
    end
  end
end
