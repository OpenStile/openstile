class PartExposureTolerance < ActiveRecord::Base
  belongs_to :part
  belongs_to :style_profile

  validates :part_id, presence: true
  validates :style_profile_id, presence: true

  def self.parts_to_cover_for style_profile_id
    where(style_profile_id: style_profile_id, tolerance: 1)
  end

  def self.parts_to_flaunt_for style_profile_id
    where(style_profile_id: style_profile_id, tolerance: 10)
  end
end
