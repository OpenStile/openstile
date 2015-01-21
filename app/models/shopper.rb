class Shopper < ActiveRecord::Base
  has_one :style_profile, dependent: :destroy
  has_many :drop_ins, dependent: :destroy

  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :trackable, :validatable #, :confirmable,

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  VALID_CELL_PHONE_REGEX = /\A\d{10,11}\z/

  before_validation(on: :create) do
    cell_phone.gsub!(/[^0-9]/, "") if attribute_present?("cell_phone")
  end
  before_save { email.downcase! }                                    
  after_create { create_style_profile }

  validates :first_name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 100 },
                                    format: { with: VALID_EMAIL_REGEX },
                                    uniqueness: { case_sensitive: false }
  validates :cell_phone, format: { with: VALID_CELL_PHONE_REGEX, message: "must be 10 or 11 numeric digits." }, 
                         unless: "cell_phone.nil? or cell_phone.empty?"
  validates :password,  length: { minimum: 6 }

end
