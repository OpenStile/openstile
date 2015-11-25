class AddQuoteToRetailer < ActiveRecord::Migration
  def change
    add_column :retailers, :quote, :string
  end
end
