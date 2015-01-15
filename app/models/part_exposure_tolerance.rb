class PartExposureTolerance < ActiveRecord::Base
  belongs_to :part
  belongs_to :style_profile

  validates :part_id, presence: true
  validates :style_profile_id, presence: true
end
