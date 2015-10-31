class PriceRange < ActiveRecord::Base
  belongs_to :retailer

  validates :retailer_id, presence: true, on: :update

end
