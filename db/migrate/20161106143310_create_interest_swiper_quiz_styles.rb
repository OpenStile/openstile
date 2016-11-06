class CreateInterestSwiperQuizStyles < ActiveRecord::Migration
  def change
    create_table :interest_swiper_quiz_styles do |t|
      t.string :image
      t.string :title

      t.timestamps
    end
  end
end
