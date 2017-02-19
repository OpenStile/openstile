class CreateInterestSwiperQuizProfiles < ActiveRecord::Migration
  def change
    create_table :interest_swiper_quiz_profiles do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.jsonb :needs
      t.string :retailer_matches

      t.timestamps
    end

    add_index :interest_swiper_quiz_profiles, :email, unique: true
  end
end
