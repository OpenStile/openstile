class RemoveColumnsFromInterestSwiperQuizSessions < ActiveRecord::Migration
  def change
    remove_column :interest_swiper_quiz_sessions, :first_name
    remove_column :interest_swiper_quiz_sessions, :last_name
    remove_column :interest_swiper_quiz_sessions, :email
  end
end
