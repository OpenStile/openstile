class Top < ActiveRecord::Base
  belongs_to :retailer
  belongs_to :look
  belongs_to :color
  has_and_belongs_to_many :top_sizes
  has_many :exposed_parts, as: :exposable, dependent: :destroy

  validates :name, presence: true, length: { maximum: 100 } 
  validates :description, presence: true, length: { maximum: 250 }
  validates :web_link, length: { maximum: 100 }
  validates :price, presence: true
  validates :retailer_id, presence: true

  def self.within_budget budget, fuzz
    if budget.top_min_price.nil? or budget.top_max_price.nil?
      return none
    end
    where("price >= ? and price <= ?", budget.top_min_price - fuzz,
                                       budget.top_max_price + fuzz)
  end
end
