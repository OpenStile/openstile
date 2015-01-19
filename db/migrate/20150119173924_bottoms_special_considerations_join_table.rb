class BottomsSpecialConsiderationsJoinTable < ActiveRecord::Migration
  def change
    create_join_table :bottoms, :special_considerations do |t|
      t.index [:bottom_id, :special_consideration_id], name: "special_considerations_for_a_bottom_index"
      t.index [:special_consideration_id, :bottom_id], name: "bottoms_for_a_special_consideration_index"
    end
  end
end
