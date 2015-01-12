class CreateDressSizes < ActiveRecord::Migration
  def change
    create_table :dress_sizes do |t|
      t.string :name

      t.timestamps
    end
  end
end
