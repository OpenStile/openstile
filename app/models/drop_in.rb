class DropIn < ActiveRecord::Base
  Time::DATE_FORMATS[:month_slash_day] = "%_m#{'/'}%d"
  Time::DATE_FORMATS[:informal_time] = "%l:%M %p"

  belongs_to :retailer
  belongs_to :shopper
  has_many :drop_in_items, dependent: :destroy

  validate :retailer_available_for_drop_in, on: :create
  validates :retailer_id, presence: true
  validates :shopper_id, presence: true
  validates :time, presence: true
  validates :comment, length: {maximum: 250}

  accepts_nested_attributes_for :drop_in_items
  default_scope { order('time ASC') }

  def retailer_available_for_drop_in
    unless retailer_id.nil? || time.nil?
      unless Retailer.find(retailer_id).available_for_drop_in?(time)
        errors.add(:time, "is not an available time slot for a drop in")
      end
    end
  end

  def self.upcoming_for shopper_id
    where("shopper_id = ? and time > ?", shopper_id, DateTime.current)
  end

  def self.upcoming_for_shopper_at_retailer shopper_id, retailer_id
    where("shopper_id = ? and retailer_id = ? and time > ?", 
                          shopper_id, retailer_id, DateTime.current)
  end

  def colloquial_time
    if time.to_date == DateTime.current.to_date
      date_string = "Today"
    elsif time.to_date == DateTime.current.advance(days: 1).to_date
      date_string = "Tomorrow"
    else
      date_string = time.to_s(:month_slash_day)
    end

    time_string = time.to_s(:informal_time)

    "#{date_string} @ #{time_string}".gsub(":00",'')
  end
end
