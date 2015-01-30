class AddIndexToDropInItemsDropInReservable < ActiveRecord::Migration
  def change
    add_index :drop_in_items, [:drop_in_id, :reservable_id, :reservable_type], unique: true, name: "unique_drop_in_items_index"
  end
end
