class CreateRetailersTopSizesJoinTable < ActiveRecord::Migration
  def change
    create_join_table :retailers, :top_sizes do |t|
      t.index [:retailer_id, :top_size_id], name: "retailer_top_sizes_index"
      t.index [:top_size_id, :retailer_id], name: "retailers_for_a_top_size_index"
    end
  end
end
