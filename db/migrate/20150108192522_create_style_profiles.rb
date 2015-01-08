class CreateStyleProfiles < ActiveRecord::Migration
  def change
    create_table :style_profiles do |t|
      t.belongs_to :shopper, index: true
      t.timestamps
    end
  end
end
