class Outfit < ActiveRecord::Base
  include ImageName

  belongs_to :retailer
  belongs_to :look
  belongs_to :body_shape
  belongs_to :top_fit
  belongs_to :bottom_fit

  has_many :drop_in_items, as: :reservable, dependent: :destroy
  has_many :exposed_parts, as: :exposable, dependent: :destroy

  has_and_belongs_to_many :dress_sizes
  has_and_belongs_to_many :top_sizes
  has_and_belongs_to_many :bottom_sizes
  has_and_belongs_to_many :prints
  has_and_belongs_to_many :colors
  has_and_belongs_to_many :special_considerations

  validates :retailer, presence: true
  validates :average_price, presence: true
  validates :name, presence: true, length: { maximum: 100 } 
  validates :price_description, presence: true, length: { maximum: 100 } 
  validates :description, presence: true, length: { maximum: 250 } 
end
