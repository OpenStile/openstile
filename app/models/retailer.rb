class Retailer < ActiveRecord::Base
  include ImageName
  include StatusLive
  include FeedSummary

  has_one :user, dependent: :destroy

  belongs_to :body_shape
  belongs_to :look
  belongs_to :primary_look, class_name: "Look"
  belongs_to :location
  belongs_to :top_fit
  belongs_to :bottom_fit
  has_and_belongs_to_many :special_considerations
  has_one :online_presence, dependent: :destroy
  has_many :drop_in_availabilities, dependent: :destroy
  has_many :drop_ins, dependent: :destroy

  accepts_nested_attributes_for :online_presence

  validates :name, presence: true, length: { maximum: 50 } 
  validates :description, presence: true, length: { maximum: 500 }
  validates :location_id, presence: true
  validates :size_range, presence: true
  validates :price_index, presence: true
  validates :quote, presence: true, length: { maximum: 100 }

  MAX_PRICE_RANGE_INDEX = 4
  GENERIC_SIZE_REGEX = /(X*S)|M|(X*L)/
  ORDERED_SIZES = ['XXS', 'XS', 'S', 'M', 'L', 'XL', 'XXL']

  def self.showcase
    where(status: 1).where("above_fold_image <> ''")
  end

  def to_param
    "#{id}-#{name.parameterize}"
  end

  def available_for_drop_in? datetime
    drop_in_availabilities.order('created_at DESC').each do |availability|
      if availability.covers_datetime? datetime
        concurrent_drop_ins = drop_ins.overlapping(datetime, datetime.advance(minutes: 30))
        if concurrent_drop_ins.count >= availability.bandwidth
          return false
        end
        return true
      end
    end

    return false
  end

  def get_available_drop_in_dates format=:integer_array, 
                                  start_day=Time.zone.today.at_beginning_of_month,
                                  end_day=Time.zone.today.at_end_of_month

    ret = []
    current_day = start_day
    while(current_day <= end_day) do
      unless get_available_drop_in_times(current_day.to_s).empty?
        case format
        when :integer_array
          ret << [current_day.year, 
                  current_day.month - 1, 
                  current_day.day]
        when :date_string
          ret << current_day.strftime("%Y-%m-%d")
        else
        end
      end

      current_day = current_day.advance(days: 1)
    end
    ret
  end

  def get_drop_in_location date_string
    availability = get_relevant_availability date_string 
    return nil if availability.nil?
    availability.location
  end

  def get_available_drop_in_times date_string
    ret = []
    parsed_date = Time.zone.parse(date_string).to_date
    availability = get_relevant_availability date_string 
    return ret if availability.nil?

    start_time, end_time = availability.applied_start_and_end_times(parsed_date)

    first_time_slot = start_time
    if first_time_slot < Time.zone.now
        buffer = Time.zone.now.advance(minutes: 30)
      if buffer.min < 30
        first_time_slot = buffer.change(min: 30)
      else
        first_time_slot = buffer.change(hour: (buffer.hour + 1))
      end
    end

    while (first_time_slot < end_time) do
      concurrent_drop_ins = self.drop_ins.overlapping(first_time_slot, first_time_slot.advance(minutes: 30))

      unless concurrent_drop_ins.count >= availability.bandwidth
        time_string = first_time_slot.strftime("%-H:%-M")
        ret << time_string.split(':').map{|v| v.to_i}
      end

      first_time_slot = first_time_slot.advance(minutes: 30)
    end

    ret
  end

  def get_relevant_availability date_string
    parsed_date = Time.zone.parse(date_string).to_date
    drop_in_availabilities.order('created_at DESC').find{|a| a.covers_date? parsed_date }
  end
end
