class CreateDropInAvailabilities < ActiveRecord::Migration
  def change
    create_table :drop_in_availabilities do |t|
      t.references :retailer, index: true
      t.datetime :start_time
      t.datetime :end_time
      t.integer :bandwidth

      t.timestamps
    end
  end
end
