module InterestSwiperQuiz
  class Profile < ActiveRecord::Base
    self.table_name = 'interest_swiper_quiz_profiles'

    has_many :sessions, :class_name => 'InterestSwiperQuiz::Session', dependent: :destroy

    validates :email, presence: true, uniqueness: {case_sensitive: false}
  end
end