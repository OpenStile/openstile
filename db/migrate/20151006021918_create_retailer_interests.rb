class CreateRetailerInterests < ActiveRecord::Migration
  def change
    create_table :retailer_interests do |t|
      t.string :first_name

      t.timestamps
    end
  end
end
