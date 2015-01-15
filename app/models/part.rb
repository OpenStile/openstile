class Part < ActiveRecord::Base
  has_many :part_exposure_tolerances, dependent: :destroy
  has_many :exposed_parts, dependent: :destroy
end
