class Part < ActiveRecord::Base
  has_many :part_exposure_tolerances, dependent: :destroy
end
