class Look < ActiveRecord::Base
  has_many :look_tolerances, dependent: :destroy
  has_many :retailers
end
