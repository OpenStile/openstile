class AddPrintReferenceToBottoms < ActiveRecord::Migration
  def change
    add_reference :bottoms, :print, index: true
  end
end
