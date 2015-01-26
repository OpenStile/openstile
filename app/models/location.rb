class Location < ActiveRecord::Base
  has_many :retailers
  has_many :drop_in_availabilities

  validate :address_cannot_be_parsed
  validates :address, presence: true, length: { maximum: 100 }
  validates :neighborhood, presence: true, length: { maximum: 50 }
  validates :short_title, length: { maximum: 100 }

  def address_cannot_be_parsed
    if StreetAddress::US.parse(address).nil?
      error_string = "is invalid format. Try formatting like '1600 Pennsylvania Ave, Washington, DC'"
      errors.add(:address, error_string)
    end
  end
end
