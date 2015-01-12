class CreateTopSizes < ActiveRecord::Migration
  def change
    create_table :top_sizes do |t|
      t.string :name

      t.timestamps
    end
  end
end
