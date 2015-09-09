class Look < ActiveRecord::Base
  has_many :retailers
  has_many :tops
  has_many :bottoms
  has_many :dresses
  has_and_belongs_to_many :style_profiles
end
