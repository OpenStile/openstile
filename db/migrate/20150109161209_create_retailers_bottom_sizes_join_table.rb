class CreateRetailersBottomSizesJoinTable < ActiveRecord::Migration
  def change
    create_join_table :retailers, :bottom_sizes do |t|
      t.index [:retailer_id, :bottom_size_id], name: "retailer_bottom_sizes_index"
      t.index [:bottom_size_id, :retailer_id], name: "retailers_for_a_bottom_size_index"
    end
  end
end
