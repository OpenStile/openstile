class BodyShape < ActiveRecord::Base
  has_many :style_profiles
  has_many :retailers
  has_many :tops
  has_many :bottoms
  has_many :dresses
end
