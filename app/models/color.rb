class Color < ActiveRecord::Base
  has_many :hated_colors, dependent: :destroy
end
