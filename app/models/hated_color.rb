class HatedColor < ActiveRecord::Base
  belongs_to :style_profile
  belongs_to :color

  validates :style_profile_id, presence: true
  validates :color_id, presence: true
end
