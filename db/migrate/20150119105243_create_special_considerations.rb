class CreateSpecialConsiderations < ActiveRecord::Migration
  def change
    create_table :special_considerations do |t|
      t.string :name

      t.timestamps
    end
  end
end
