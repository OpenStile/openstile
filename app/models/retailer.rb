class Retailer < ActiveRecord::Base
  has_and_belongs_to_many :top_sizes
  has_and_belongs_to_many :bottom_sizes
  has_and_belongs_to_many :dress_sizes
  has_one :price_range, dependent: :destroy
  belongs_to :body_shape
  belongs_to :look
  belongs_to :primary_look, class_name: "Look"
  has_many :tops, dependent: :destroy
  has_many :bottoms, dependent: :destroy
  has_many :dresses, dependent: :destroy
  has_and_belongs_to_many :special_considerations
  has_one :online_presence, dependent: :destroy
  has_many :drop_in_availabilities, dependent: :destroy
  has_one :location, as: :locatable, dependent: :destroy
  has_many :drop_ins, dependent: :destroy

  after_create{ create_price_range }
  
  validates :name, presence: true, length: { maximum: 50 } 
  validates :neighborhood, presence: true, length: { maximum: 50 } 
  validates :description, presence: true, length: { maximum: 250 } 

  def available_for_drop_in? datetime
    future_availabilities = self.drop_in_availabilities.where("end_time > ?", DateTime.current)

    future_availabilities.each do |availability|
      if datetime > availability.start_time && datetime < availability.end_time
        concurrent_drop_ins = drop_ins.where(time: datetime)
        if concurrent_drop_ins.count >= availability.bandwidth
          return false
        end
        return true
      end
    end

    return false
  end

  def get_available_drop_in_dates zero_index_month=false
    ret = []
    future_availabilities = self.drop_in_availabilities.where("end_time > ?", DateTime.current)
    future_availabilities.each do |availability|
      ary = availability.start_time.to_date.strftime("%Y-%-m-%d").split('-').map{|v| v.to_i}
      ary[1] = ary[1] - 1 if zero_index_month
      ret << ary
    end
    ret
  end
end
