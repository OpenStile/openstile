class AddPasswordDigestToShoppers < ActiveRecord::Migration
  def change
    add_column :shoppers, :password_digest, :string
  end
end
