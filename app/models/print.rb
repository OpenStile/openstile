class Print < ActiveRecord::Base
  has_many :print_tolerances, dependent: :destroy
  has_many :tops
  has_many :bottoms
  has_many :dresses
  has_and_belongs_to_many :outfits
end
