class CreateDropIns < ActiveRecord::Migration
  def change
    create_table :drop_ins do |t|
      t.references :retailer, index: true
      t.references :shopper, index: true
      t.datetime :time

      t.timestamps
    end
  end
end
