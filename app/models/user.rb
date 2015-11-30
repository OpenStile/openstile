class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  scope :shoppers,  ->() { where(user_role_id: UserRole.find_by_name(UserRole::SHOPPER).id) }
  scope :admins,    ->() { where(user_role_id: UserRole.find_by_name(UserRole::ADMIN).id) }
  scope :retailers, ->() { where(user_role_id: UserRole.find_by_name(UserRole::RETAILER).id) }

  belongs_to :user_role
  has_one :style_profile, dependent: :destroy
  has_many :drop_ins, dependent: :destroy
  belongs_to :retailer

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  VALID_CELL_PHONE_REGEX = /\A\d{10,11}\z/

  before_validation(on: :create) do
    cell.gsub!(/[^0-9]/, "") if attribute_present?("cell")
  end
  before_save { email.downcase! }
  after_create { create_style_profile }

  validates :first_name, presence: true, length: { maximum: 50 }
  validates :last_name, presence: false, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 100 },
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }
  validates :cell, format: { with: VALID_CELL_PHONE_REGEX, message: "must be 10 or 11 numeric digits." },
            unless: "cell.nil? or cell.empty?"
  validates :password,  length: { minimum: 6 }
  validates :user_role_id, presence: true
  validates :retailer_id, presence: true, if: "!user_role.nil? and user_role.name == UserRole::RETAILER"
  validates :last_name, presence: true, if: "!user_role.nil? and user_role.name == UserRole::RETAILER"
end
