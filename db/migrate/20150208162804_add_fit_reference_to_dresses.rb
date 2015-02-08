class AddFitReferenceToDresses < ActiveRecord::Migration
  def change
    remove_column :dresses, :top_fit, :string
    remove_column :dresses, :bottom_fit, :string
    add_reference :dresses, :top_fit, index: true
    add_reference :dresses, :bottom_fit, index: true
  end
end
