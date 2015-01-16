class AddPrintReferenceToTops < ActiveRecord::Migration
  def change
    add_reference :tops, :print, index: true
  end
end
