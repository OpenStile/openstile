class Budget < ActiveRecord::Base
  belongs_to :style_profile

  validates :style_profile_id, presence: true
end
