class CreateRetailersSpecialConsiderationsJoinTable < ActiveRecord::Migration
  def change
    create_join_table :retailers, :special_considerations do |t|
      t.index [:retailer_id, :special_consideration_id], name: "special_considerations_for_a_retailer_index"
      t.index [:special_consideration_id, :retailer_id], name: "retailers_for_a_special_consideration_index"
    end
  end
end
