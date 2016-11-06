class CreateInterestSwiperQuizLikes < ActiveRecord::Migration
  def change
    create_table :interest_swiper_quiz_likes do |t|
      t.integer :style_id
      t.integer :session_id

      t.timestamps
    end

    add_index :interest_swiper_quiz_likes, :session_id
  end
end
