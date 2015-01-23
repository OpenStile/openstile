class DropIn < ActiveRecord::Base
  belongs_to :retailer
  belongs_to :shopper
  has_many :drop_in_items, dependent: :destroy

  validate :retailer_available_for_drop_in, on: :create
  validates :retailer_id, presence: true
  validates :shopper_id, presence: true
  validates :time, presence: true
  validates :comment, length: {maximum: 250}

  def retailer_available_for_drop_in
    unless retailer_id.nil? || time.nil?
      unless Retailer.find(retailer_id).available_for_drop_in_at(time)
        errors.add(:time, "is not an available time slot for a drop in")
      end
    end
  end

  def self.upcoming_for shopper_id
    where("shopper_id = ? and time > ?", shopper_id, DateTime.current)
  end
end
