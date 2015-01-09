class CreateRetailersDressSizesJoinTable < ActiveRecord::Migration
  def change
    create_join_table :retailers, :dress_sizes do |t|
      t.index [:retailer_id, :dress_size_id], name: "retailer_dress_sizes_index"
      t.index [:dress_size_id, :retailer_id], name: "retailers_for_a_dress_size_index"
    end
  end
end
