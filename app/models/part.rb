class Part < ActiveRecord::Base
  has_many :exposed_parts, dependent: :destroy
end
