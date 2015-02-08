class DropInAvailability < ActiveRecord::Base
  belongs_to :retailer
  belongs_to :location
  
  validate :start_and_end_time_on_same_day, 
           :end_time_after_start_time
  validates :retailer_id, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :bandwidth, presence: true
  validates :location_id, presence: true

  def start_and_end_time_on_same_day
    unless start_time.nil? or end_time.nil?
      if start_time.at_beginning_of_day != end_time.at_beginning_of_day
        errors.add(:end_time, "must be the same date as start time")
      end
    end
  end

  def end_time_after_start_time
    unless start_time.nil? or end_time.nil?
      if end_time < start_time
        errors.add(:end_time, "must be later than start time")
      end
    end
  end

  def self.for_retailer_on_date retailer_id, date_string
    date = DateTime.parse(date_string).change(offset: '-0500')
    where("retailer_id = ? and start_time >= ? and end_time <= ?",
                         retailer_id,
                         date.at_beginning_of_day,
                         date.at_end_of_day).first
  end
end
