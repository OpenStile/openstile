class AddRatingsToDropIns < ActiveRecord::Migration
  def change
    add_column :drop_ins, :shopper_rating, :integer
    add_column :drop_ins, :retailer_rating, :integer
    add_column :drop_ins, :shopper_feedback, :string
    add_column :drop_ins, :retailer_feedback, :string
    add_column :drop_ins, :sales_generated, :decimal
  end
end
