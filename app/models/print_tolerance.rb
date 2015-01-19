class PrintTolerance < ActiveRecord::Base
  belongs_to :style_profile
  belongs_to :print

  validates :style_profile_id, presence: true
  validates :print_id, presence: true

  def self.hated_prints_for style_profile_id
    where(style_profile_id: style_profile_id, tolerance: 1)
  end

  def self.favorite_prints_for style_profile_id
    where(style_profile_id: style_profile_id, tolerance: 10)
  end
end
