class ChangeRetailUserCellPhoneToPhoneNumber < ActiveRecord::Migration
  def change
    rename_column :retail_users, :cell_phone, :phone_number
  end
end
