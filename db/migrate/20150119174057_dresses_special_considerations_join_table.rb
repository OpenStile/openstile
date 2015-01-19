class DressesSpecialConsiderationsJoinTable < ActiveRecord::Migration
  def change
    create_join_table :dresses, :special_considerations do |t|
      t.index [:dress_id, :special_consideration_id], name: "special_considerations_for_a_dress_index"
      t.index [:special_consideration_id, :dress_id], name: "dresses_for_a_special_consideration_index"
    end
  end
end
