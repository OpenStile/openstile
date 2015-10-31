class BodyShape < ActiveRecord::Base
  has_many :style_profiles
  has_many :retailers
end
