class PrintTolerance < ActiveRecord::Base
  belongs_to :style_profile
  belongs_to :print

  validates :style_profile_id, presence: true
  validates :print_id, presence: true
end
