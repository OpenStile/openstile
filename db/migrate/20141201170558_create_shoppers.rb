class CreateShoppers < ActiveRecord::Migration
  def change
    create_table :shoppers do |t|
      t.string :first_name
      t.string :email
      t.string :cell_phone

      t.timestamps
    end
  end
end
