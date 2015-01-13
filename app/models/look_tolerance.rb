class LookTolerance < ActiveRecord::Base
  belongs_to :style_profile
  belongs_to :look

  validates :style_profile_id, presence: true
  validates :look_id, presence: true
end
