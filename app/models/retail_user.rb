class RetailUser < ActiveRecord::Base
  include Callable

  belongs_to :retailer
  validates :retailer, :presence => true

  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :trackable, :validatable #, :confirmable,

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  before_save { email.downcase! }

  validates :email, presence: true, length: { maximum: 100 },
                                    format: { with: VALID_EMAIL_REGEX },
                                    uniqueness: { case_sensitive: false }
  validates :password,  length: { minimum: 6 }

end
