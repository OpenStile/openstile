class Favorite < ActiveRecord::Base
  belongs_to :shopper
  belongs_to :favoriteable, polymorphic: true

  validates :shopper, presence: true
  validates :favoriteable, presence: true
end
