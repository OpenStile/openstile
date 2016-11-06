module InterestSwiperQuiz
  class Like < ActiveRecord::Base
    self.table_name = 'interest_swiper_quiz_likes'
    
    belongs_to :session, :class_name => 'InterestSwiperQuiz::Session'
    belongs_to :style, :class_name => 'InterestSwiperQuiz::Style'
  end
end