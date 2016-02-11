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

  def serialize_model
    {referrer_name: referrer_name,
     referrer_email: referrer_email,
     store_name: store_name,
     website: website,
     contact_name: contact_name,
     contact_email: contact_email}
  end
end