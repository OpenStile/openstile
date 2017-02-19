module InterestSwiperQuiz
  class Session < ActiveRecord::Base
    self.table_name = 'interest_swiper_quiz_sessions'

    belongs_to :profile, :class_name => 'InterestSwiperQuiz::Profile'

    has_many :likes, :class_name => 'InterestSwiperQuiz::Like', dependent: :destroy
  end
end