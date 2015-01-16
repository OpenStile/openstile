class AddPrintReferenceToDresses < ActiveRecord::Migration
  def change
    add_reference :dresses, :print, index: true
  end
end
