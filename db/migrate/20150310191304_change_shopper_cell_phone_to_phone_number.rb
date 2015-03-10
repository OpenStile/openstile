class ChangeShopperCellPhoneToPhoneNumber < ActiveRecord::Migration
  def change
    rename_column :shoppers, :cell_phone, :phone_number
  end
end
