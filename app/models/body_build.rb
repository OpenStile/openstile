class BodyBuild < ActiveRecord::Base
  has_and_belongs_to_many :style_profiles
end
