class UserRole < ActiveRecord::Base
  SHOPPER = 'SHOPPER'
  RETAILER = 'RETAILER'
  ADMIN = 'ADMIN'

  has_many :users

  validates :name, presence: true, uniqueness: true
end
