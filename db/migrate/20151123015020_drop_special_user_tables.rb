class DropSpecialUserTables < ActiveRecord::Migration
  def change
    drop_table :shoppers
    drop_table :retail_users
    drop_table :admins
  end
end
