class CreateBodyBuilds < ActiveRecord::Migration
  def change
    create_table :body_builds do |t|
      t.string :name

      t.timestamps
    end
  end
end
