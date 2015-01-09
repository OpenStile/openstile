class StyleProfile < ActiveRecord::Base
  belongs_to :shopper
  has_and_belongs_to_many :top_sizes
  has_and_belongs_to_many :bottom_sizes

  validates :shopper_id, presence: true
end
