class ExposedPart < ActiveRecord::Base
  belongs_to :part
  belongs_to :exposable, polymorphic: true

  validates :part_id, presence: true
  validates :exposable, presence: true
end
