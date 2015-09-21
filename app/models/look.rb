class Look < ActiveRecord::Base
  has_many :retailers
  has_and_belongs_to_many :style_profiles
end
