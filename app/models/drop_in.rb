class DropIn < ActiveRecord::Base
  belongs_to :retailer
  belongs_to :shopper
  has_many :drop_in_items, dependent: :destroy

  validates :retailer_id, presence: true
  validates :shopper_id, presence: true
  validates :time, presence: true
end
