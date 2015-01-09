class TopSize < ActiveRecord::Base
  has_and_belongs_to_many :style_profiles
  has_and_belongs_to_many :retailers
end
