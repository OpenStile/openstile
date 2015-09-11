
class StyleProfile < ActiveRecord::Base
  belongs_to :shopper
  belongs_to :body_shape
  belongs_to :top_fit
  belongs_to :bottom_fit
  has_and_belongs_to_many :top_sizes
  has_and_belongs_to_many :bottom_sizes
  has_and_belongs_to_many :dress_sizes
  has_and_belongs_to_many :looks
  has_many :print_tolerances, dependent: :destroy
  has_and_belongs_to_many :flaunted_parts, class_name: 'Part', join_table: 'parts_to_flaunts'
  has_and_belongs_to_many :downplayed_parts, class_name: 'Part', join_table: 'parts_to_covers'
  has_and_belongs_to_many :avoided_colors, class_name: 'Color', join_table: 'colors_to_avoids'
  has_and_belongs_to_many :special_considerations
  has_and_belongs_to_many :body_builds

  accepts_nested_attributes_for :print_tolerances

  validates :shopper_id, presence: true

end
