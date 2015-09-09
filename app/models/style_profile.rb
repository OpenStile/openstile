
class StyleProfile < ActiveRecord::Base
  belongs_to :shopper
  belongs_to :body_shape
  belongs_to :top_fit
  belongs_to :bottom_fit
  has_and_belongs_to_many :top_sizes
  has_and_belongs_to_many :bottom_sizes
  has_and_belongs_to_many :dress_sizes
  has_many :look_tolerances, dependent: :destroy
  has_many :part_exposure_tolerances, dependent: :destroy
  has_many :hated_colors, dependent: :destroy
  has_many :avoided_colors, through: :hated_colors, source: :color
  has_many :print_tolerances, dependent: :destroy
  has_and_belongs_to_many :special_considerations
  has_and_belongs_to_many :body_builds

  accepts_nested_attributes_for :look_tolerances
  accepts_nested_attributes_for :part_exposure_tolerances
  accepts_nested_attributes_for :print_tolerances

  validates :shopper_id, presence: true

end
