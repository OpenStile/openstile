class AddFirstNameLastNameToInterestSwiperQuizSession < ActiveRecord::Migration
  def change
    add_column :interest_swiper_quiz_sessions, :first_name, :string
    add_column :interest_swiper_quiz_sessions, :last_name, :string
  end
end
