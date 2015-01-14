class Dress < ActiveRecord::Base
  belongs_to :retailer
  has_and_belongs_to_many :dress_sizes

  validates :name, presence: true, length: { maximum: 100 } 
  validates :description, presence: true, length: { maximum: 250 }
  validates :web_link, length: { maximum: 100 }
  validates :price, presence: true
  validates :retailer_id, presence: true
end
