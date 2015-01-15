class AddLookReferenceToDresses < ActiveRecord::Migration
  def change
    add_reference :dresses, :look, index: true
  end
end
