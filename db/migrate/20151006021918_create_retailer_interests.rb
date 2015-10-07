class CreateRetailerInterests < ActiveRecord::Migration
  def change
    create_table :retailer_interests do |t|
      t.string :first_name
      t.string :last_name
      t.string :boutique_name
      t.string :website_address
      t.string :street_address
      t.string :city
      t.string :state 
      t.integer :zip_code
      t.string :email_address
      t.integer :phone_number
      t.text :describe_store_aesthetic

      t.timestamps
    end
  end
end
