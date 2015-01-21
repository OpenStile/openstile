class DropIn < ActiveRecord::Base
  belongs_to :retailer
  belongs_to :shopper

  validates :retailer_id, presence: true
  validates :shopper_id, presence: true
  validates :time, presence: true
end
