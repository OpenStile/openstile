class AddIndexToDropInsShopperIdTime < ActiveRecord::Migration
  def change
    add_index :drop_ins, [:shopper_id, :time], unique: true
  end
end
