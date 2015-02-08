class PriceRange < ActiveRecord::Base
  belongs_to :retailer

  validates :retailer_id, presence: true, on: :update

  def self.overlap_with_top_budget budget
    where("top_max_price >= ? and top_min_price <= ?", budget.top_min_price, budget.top_max_price)
  end

  def self.overlap_with_bottom_budget budget
    where("bottom_max_price >= ? and bottom_min_price <= ?", budget.bottom_min_price, budget.bottom_max_price)
  end

  def self.overlap_with_dress_budget budget
    where("dress_max_price >= ? and dress_min_price <= ?", budget.dress_min_price, budget.dress_max_price)
  end
end
