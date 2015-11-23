class AddUserReferenceToStyleProfile < ActiveRecord::Migration
  def change
    remove_reference :style_profiles, :shopper
    add_reference :style_profiles, :user, index: true
  end
end
