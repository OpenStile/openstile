class CreateOnlinePresences < ActiveRecord::Migration
  def change
    create_table :online_presences do |t|
      t.references :retailer, index: true
      t.string :web_link
      t.string :facebook_link
      t.string :twitter_link
      t.string :instagram_link

      t.timestamps
    end
  end
end
