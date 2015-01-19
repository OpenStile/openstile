class SpecialConsideration < ActiveRecord::Base
  has_and_belongs_to_many :style_profiles
  has_and_belongs_to_many :retailers
  has_and_belongs_to_many :tops
  has_and_belongs_to_many :bottoms
  has_and_belongs_to_many :dresses
end
