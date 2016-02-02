class AddStatusToDropIn < ActiveRecord::Migration
  def change
    add_column :drop_ins, :status, :integer, default: 1
  end
end
