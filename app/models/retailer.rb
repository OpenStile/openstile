class Retailer < ActiveRecord::Base
  has_and_belongs_to_many :top_sizes
  has_and_belongs_to_many :bottom_sizes
  has_and_belongs_to_many :dress_sizes
  has_one :price_range, dependent: :destroy
  belongs_to :primary_look, class_name: "Look"

  after_create{ create_price_range }
  
  validates :name, presence: true, length: { maximum: 50 } 
  validates :neighborhood, presence: true, length: { maximum: 50 } 
  validates :description, presence: true, length: { maximum: 250 } 
end
