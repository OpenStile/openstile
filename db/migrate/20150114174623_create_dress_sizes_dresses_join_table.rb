class CreateDressSizesDressesJoinTable < ActiveRecord::Migration
  def change
    create_join_table :dresses, :dress_sizes do |t|
      t.index [:dress_id, :dress_size_id], name: "sizes_for_a_dress_index"
      t.index [:dress_size_id, :dress_id], name: "dresses_of_a_size_index"
    end
  end
end
