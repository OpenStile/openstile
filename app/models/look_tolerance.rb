class LookTolerance < ActiveRecord::Base
  belongs_to :style_profile
  belongs_to :look

  validates :style_profile_id, presence: true
  validates :look_id, presence: true

  def self.hated_looks_for style_profile_id
    where(style_profile_id: style_profile_id, tolerance: 1)
  end
end
