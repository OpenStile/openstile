class CreateLooks < ActiveRecord::Migration
  def change
    create_table :looks do |t|
      t.string :name

      t.timestamps
    end
  end
end
