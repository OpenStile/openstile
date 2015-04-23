class Shopper < ActiveRecord::Base
  include Callable

  has_one :style_profile, dependent: :destroy
  has_many :drop_ins, dependent: :destroy
  has_many :favorites, dependent: :destroy

  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :trackable, :validatable, :confirmable

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  before_save { email.downcase! }
  after_create { create_style_profile }

  validates :first_name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 100 },
                                    format: { with: VALID_EMAIL_REGEX },
                                    uniqueness: { case_sensitive: false }

  validates :password,  length: { minimum: 6 }

end
