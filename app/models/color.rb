class Color < ActiveRecord::Base
  has_many :hated_colors, dependent: :destroy
  has_many :tops
  has_many :bottoms
  has_many :dresses

  has_and_belongs_to_many :outfits

  default_scope { order('name ASC') }
end
