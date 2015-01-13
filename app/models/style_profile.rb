class StyleProfile < ActiveRecord::Base
  belongs_to :shopper
  has_and_belongs_to_many :top_sizes
  has_and_belongs_to_many :bottom_sizes
  has_and_belongs_to_many :dress_sizes
  has_one :budget, dependent: :destroy
  accepts_nested_attributes_for :budget

  after_create { create_budget }

  validates :shopper_id, presence: true
end
