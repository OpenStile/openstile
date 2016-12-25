module InterestSwiperQuiz
  class Session < ActiveRecord::Base
    self.table_name = 'interest_swiper_quiz_sessions'

    has_many :likes, :class_name => 'InterestSwiperQuiz::Like', dependent: :destroy

    validates :email, presence: true, uniqueness: true
  end
end