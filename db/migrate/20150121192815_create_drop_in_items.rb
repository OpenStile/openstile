class CreateDropInItems < ActiveRecord::Migration
  def change
    create_table :drop_in_items do |t|
      t.references :drop_in, index: true
      t.references :reservable, polymorphic: true, index: true

      t.timestamps
    end
  end
end
