class TopsSpecialConsiderationsJoinTable < ActiveRecord::Migration
  def change
    create_join_table :tops, :special_considerations do |t|
      t.index [:top_id, :special_consideration_id], name: "special_considerations_for_a_top_index"
      t.index [:special_consideration_id, :top_id], name: "tops_for_a_special_consideration_index"
    end
  end
end
