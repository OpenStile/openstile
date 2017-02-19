class AddProfileToInterestSwiperQuizSessions < ActiveRecord::Migration
  def change
    add_column :interest_swiper_quiz_sessions, :profile_id, :integer

    add_index :interest_swiper_quiz_sessions, :profile_id
  end
end
