class Retailer < ActiveRecord::Base
  has_one :retail_user, dependent: :destroy

  has_and_belongs_to_many :top_sizes
  has_and_belongs_to_many :bottom_sizes
  has_and_belongs_to_many :dress_sizes
  has_one :price_range, dependent: :destroy
  belongs_to :body_shape
  belongs_to :look
  belongs_to :primary_look, class_name: "Look"
  belongs_to :location
  has_many :tops, dependent: :destroy
  has_many :bottoms, dependent: :destroy
  has_many :dresses, dependent: :destroy
  has_and_belongs_to_many :special_considerations
  has_one :online_presence, dependent: :destroy
  has_many :drop_in_availabilities, dependent: :destroy
  has_many :drop_ins, dependent: :destroy

  after_create{ create_price_range }

  validates :name, presence: true, length: { maximum: 50 }
  validates :description, presence: true, length: { maximum: 250 }
  validates :location_id, presence: true

  def available_for_drop_in? datetime
    future_availabilities.each do |availability|
      if datetime >= availability.start_time && datetime < availability.end_time
        concurrent_drop_ins = drop_ins.where(time: datetime)
        if concurrent_drop_ins.count >= availability.bandwidth
          return false
        end
        return true
      end
    end

    return false
  end

  def get_available_drop_in_dates format=:integer_array
    ret = []
    future_availabilities.each do |availability|
      case format
      when :integer_array
        ret << [availability.start_time.year, 
                availability.start_time.month - 1, 
                availability.start_time.day]
      when :date_string
        ret << availability.start_time.strftime("%Y-%m-%d")
      else
      end
    end
    ret
  end

  def get_drop_in_location date_string
    matching_index = future_availabilities.index { |availability|
      availability.start_time.to_date == DateTime.parse(date_string).to_date
    }

    availability = future_availabilities[matching_index]

    return nil if availability.nil?
    availability.location
  end

  def get_available_drop_in_times date_string
    ret = []
    matching_index = future_availabilities.index { |availability|
      availability.start_time.to_date == DateTime.parse(date_string).to_date
    }

    return ret if matching_index.nil?

    availability = future_availabilities[matching_index]

    first_time_slot = availability.start_time
    if first_time_slot < DateTime.current
      buffer = DateTime.current.advance(minutes: 30)
      if buffer.minute < 30
        first_time_slot = buffer.change(min: 30)
      else
        first_time_slot = buffer.change(hour: (buffer.hour + 1))
      end
    end

    while (first_time_slot < availability.end_time) do
      concurrent_drop_ins = self.drop_ins.where(time: first_time_slot)

      unless concurrent_drop_ins.count >= availability.bandwidth
        time_string = first_time_slot.strftime("%-H:%-M")
        ret << time_string.split(':').map{|v| v.to_i}
      end

      first_time_slot = first_time_slot.advance(minutes: 30)
    end

    ret
  end

  def image_name
    address = StreetAddress::US.parse(self.location.address)
    state = address.state.gsub(' ','_')
    city = address.city.gsub(' ','_')
    name = self.name.gsub(' ','_')
    [state, city, name].join('_').concat('.jpg')
  end

  private
    def future_availabilities
      self.drop_in_availabilities.where("end_time > ?", DateTime.current)
    end
end
