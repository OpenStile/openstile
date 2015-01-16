class Color < ActiveRecord::Base
  has_many :hated_colors, dependent: :destroy

  default_scope { order('name ASC') }
end
