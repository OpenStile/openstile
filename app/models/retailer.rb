class Retailer < ActiveRecord::Base
  has_and_belongs_to_many :top_sizes
  has_and_belongs_to_many :bottom_sizes
  
  validates :name, presence: true, length: { maximum: 50 } 
  validates :neighborhood, presence: true, length: { maximum: 50 } 
  validates :description, presence: true, length: { maximum: 250 } 
end
