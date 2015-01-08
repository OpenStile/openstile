class StyleProfile < ActiveRecord::Base
  belongs_to :shopper

  validates :shopper_id, presence: true
end
