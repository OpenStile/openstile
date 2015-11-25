class AddUserReferenceToDropIn < ActiveRecord::Migration
  def change
    remove_reference :drop_ins, :shopper
    add_reference :drop_ins, :user, index: true
  end
end
