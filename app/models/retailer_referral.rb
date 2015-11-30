class RetailerReferral
  include ActiveModel::Model

  attr_accessor :referrer_name, :referrer_email, :store_name, :website, :contact_name, :contact_email

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  validates :referrer_name, presence: true, length: { maximum: 100 }
  validates :store_name, presence: true, length: { maximum: 100 }
  validates :website, presence: true, length: { maximum: 100 }
  validates :contact_name, presence: true, length: { maximum: 100 }
  validates :referrer_email, presence: true, length: { maximum: 100 }, format: { with: VALID_EMAIL_REGEX }
  validates :contact_email, presence: true, length: { maximum: 100 }, format: { with: VALID_EMAIL_REGEX }
end