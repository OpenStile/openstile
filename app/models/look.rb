class Look < ActiveRecord::Base
  has_many :look_tolerances, dependent: :destroy
  has_many :retailers
  has_many :tops
  has_many :bottoms
  has_many :dresses
end
