class CreateInterestSwiperQuizSessions < ActiveRecord::Migration
  def change
    create_table :interest_swiper_quiz_sessions do |t|
      t.string :email
      t.boolean :completed

      t.timestamps
    end

    add_index :interest_swiper_quiz_sessions, :email, unique: true
  end
end
