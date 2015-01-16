class Color < ActiveRecord::Base
  has_many :hated_colors, dependent: :destroy
  has_many :tops
  has_many :bottoms
  has_many :dresses

  default_scope { order('name ASC') }
end
