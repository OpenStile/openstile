class Look < ActiveRecord::Base
  has_many :look_tolerances, dependent: :destroy
end
