class Dress < ActiveRecord::Base
  include ImageName
  include StatusLive

  belongs_to :retailer
  belongs_to :look
  belongs_to :color
  belongs_to :print
  belongs_to :body_shape
  belongs_to :top_fit
  belongs_to :bottom_fit
  has_and_belongs_to_many :dress_sizes
  has_and_belongs_to_many :special_considerations
  has_many :exposed_parts, as: :exposable, dependent: :destroy
  has_many :drop_in_items, as: :reservable, dependent: :destroy

  validates :name, presence: true, length: { maximum: 100 } 
  validates :description, presence: true, length: { maximum: 250 }
  validates :web_link, length: { maximum: 100 }
  validates :price, presence: true
  validates :retailer_id, presence: true

  def self.within_budget budget, fuzz
    if budget.dress_min_price.nil? or budget.dress_max_price.nil?
      return none
    end
    where("price >= ? and price <= ?", budget.dress_min_price - fuzz,
                                       budget.dress_max_price + fuzz)
  end
end
