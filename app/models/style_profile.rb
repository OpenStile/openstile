
class StyleProfile < ActiveRecord::Base
  belongs_to :user
  belongs_to :body_shape
  belongs_to :top_fit
  belongs_to :bottom_fit
  has_and_belongs_to_many :top_sizes
  has_and_belongs_to_many :bottom_sizes
  has_and_belongs_to_many :dress_sizes
  has_and_belongs_to_many :looks
  has_and_belongs_to_many :flaunted_parts, class_name: 'Part', join_table: 'parts_to_flaunts'
  has_and_belongs_to_many :downplayed_parts, class_name: 'Part', join_table: 'parts_to_covers'
  has_and_belongs_to_many :avoided_colors, class_name: 'Color', join_table: 'colors_to_avoids'
  has_and_belongs_to_many :special_considerations
  has_and_belongs_to_many :body_builds

  validates :user_id, presence: true

  def empty?
    top_sizes.empty? && bottom_sizes.empty? && dress_sizes.empty? && body_builds.empty? &&
        body_shape.nil? && top_budget.blank? && bottom_budget.blank? && dress_budget.blank? &&
        looks.empty? && special_considerations.empty? && top_fit.nil? && bottom_fit.nil? &&
        flaunted_parts.empty? && downplayed_parts.empty? && avoided_colors.empty?
  end
end
