module InterestSwiperQuiz
  class Style < ActiveRecord::Base
    self.table_name = 'interest_swiper_quiz_styles'

    has_many :likes, :class_name => 'InterestSwiperQuiz::Like'
  end
end