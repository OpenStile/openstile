class OnlinePresence < ActiveRecord::Base
  belongs_to :retailer

  validates :retailer_id, presence: true
end
