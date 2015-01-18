class CreateBodyShapes < ActiveRecord::Migration
  def change
    create_table :body_shapes do |t|
      t.string :name
      t.string :description

      t.timestamps
    end
  end
end
