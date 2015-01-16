class Print < ActiveRecord::Base
  has_many :print_tolerances, dependent: :destroy
  has_many :tops
  has_many :bottoms
  has_many :dresses
end
