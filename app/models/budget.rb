class Budget < ActiveRecord::Base
  attr_accessor :top_range_string, :bottom_range_string, :dress_range_string

  ABSOLUTE_MIN = 0.00
  ABSOLUTE_MAX = 1000.00

  belongs_to :style_profile

  before_validation do
    unless @top_range_string.nil?
      min, max =  extract_min_max(@top_range_string)
      self.top_min_price = min
      self.top_max_price = max
    end

    unless @bottom_range_string.nil?
      min, max =  extract_min_max(@bottom_range_string)
      self.bottom_min_price = min
      self.bottom_max_price = max
    end

    unless @dress_range_string.nil?
      min, max =  extract_min_max(@dress_range_string)
      self.dress_min_price = min
      self.dress_max_price = max
    end
  end

  validates :style_profile_id, presence: true

  def top_range_string 
    @top_range_string ||= create_range_string(self.top_min_price, self.top_max_price)
  end

  def bottom_range_string 
    @bottom_range_string ||= create_range_string(self.bottom_min_price, self.bottom_max_price)
  end

  def dress_range_string 
    @dress_range_string ||= create_range_string(self.dress_min_price, self.dress_max_price)
  end

  private
    def extract_min_max budget_range_string
      # Expects budget range strings in the format: 
      # "$amount_min - $amount_max"
      # "< $amount_max"
      # "$amount_min +"

      budget_range_string.gsub!(" - "," ")
      budget_range_string.gsub!("$","")

      min, max = budget_range_string.split(" ")

      min = ABSOLUTE_MIN if min == "<"
      max = ABSOLUTE_MAX if max == "+"

      [min, max]
    end

    def create_range_string min, max
      # Generates budget range strings in the format: 
      # "$amount_min - $amount_max"
      # "< $amount_max"
      # "$amount_min +"
      return nil if min.nil? || max.nil?
      
      budget_range_string = "$#{min.to_i.to_s} - $#{max.to_i.to_s}"
      budget_range_string.gsub!(/^\$\d+\s-/, "<") if min <= ABSOLUTE_MIN
      budget_range_string.gsub!(/-\s\$\d+/, "+") if max >= ABSOLUTE_MAX

      budget_range_string
    end
end
