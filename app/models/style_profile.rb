class StyleProfile < ActiveRecord::Base
  belongs_to :shopper
  belongs_to :body_shape
  has_and_belongs_to_many :top_sizes
  has_and_belongs_to_many :bottom_sizes
  has_and_belongs_to_many :dress_sizes
  has_one :budget, dependent: :destroy
  has_many :look_tolerances, dependent: :destroy
  has_many :part_exposure_tolerances, dependent: :destroy
  has_many :hated_colors, dependent: :destroy
  has_many :avoided_colors, through: :hated_colors, source: :color
  has_many :print_tolerances, dependent: :destroy
  has_and_belongs_to_many :special_considerations

  accepts_nested_attributes_for :budget
  accepts_nested_attributes_for :look_tolerances
  accepts_nested_attributes_for :part_exposure_tolerances
  accepts_nested_attributes_for :print_tolerances

  after_create { create_budget }

  validates :shopper_id, presence: true

  def is_petite?
    return false if height_feet.nil? or height_inches.nil?
    case
    when height_feet < 5
      return true
    when height_feet > 5
      return false
    when height_feet == 5 && height_inches <= 4
      return true 
    else
      return false
    end
  end

  def is_tall?
    return false if height_feet.nil? or height_inches.nil?
    case
    when height_feet > 5
      return true
    when height_feet < 5
      return false
    when height_feet == 5 && height_inches >= 9
      return true
    else
      return false
    end
  end

  def synopsis
    ret = ""
    default_subject = 'She'

    body_description_string = synopsis_body_description
    top_size_string = synopsis_top_size
    bottom_size_string = synopsis_bottom_size
    dress_size_string = synopsis_dress_size
    budget_string = synopsis_budget
    considerations_string = synopsis_considerations
    looks_string = synopsis_looks
    fit_string = synopsis_fit
    coverage_string = synopsis_coverage
    prints_string = synopsis_prints
    colors_string = synopsis_colors

    ret << "#{self.shopper.first_name} is #{body_description_string}."
    ret << " #{default_subject} wears #{top_size_string}." unless top_size_string.blank?
    ret << " #{default_subject} wears #{bottom_size_string}." unless bottom_size_string.blank?
    ret << " #{default_subject} wears #{dress_size_string}." unless dress_size_string.blank?
    ret << " #{default_subject} spends #{budget_string}." unless budget_string.blank?
    ret << " #{default_subject} values #{considerations_string}." unless considerations_string.blank?
    ret << " #{default_subject} #{looks_string}." unless looks_string.blank?
    ret << " #{default_subject} prefers #{fit_string}." unless fit_string.blank?
    ret << " #{default_subject} prefers #{coverage_string}." unless coverage_string.blank?
    ret << " #{default_subject} #{prints_string}." unless prints_string.blank?
    ret << " Lastly, #{default_subject.downcase} avoids #{colors_string}." unless colors_string.blank?

    ret
  end

  private
    def synopsis_body_description
      ret = ""
      case
      when self.is_petite?
        ret << 'petite'
      when self.is_tall?
        ret << 'tall'
      else
        ret << 'average height'
      end

      unless self.body_build.blank?
        ret << " with #{self.body_build.downcase} build" 
      end

      unless self.body_shape_id.nil?
        ret << " and #{self.body_shape.name.downcase} shape"
      end

      ret
    end

    def synopsis_top_size
      assemble_sizes :top_sizes
    end

    def synopsis_bottom_size
      assemble_sizes :bottom_sizes
    end

    def synopsis_dress_size
      assemble_sizes :dress_sizes
    end

    def assemble_sizes type_method
      ret = ""
      baseline = type_method.to_s.singularize.gsub('_',' ')
      return ret if self.send(type_method).empty?

      ret << "#{baseline}" 

      numeric_sizes = self.send(type_method).where(category: 'numeric')
      ret << " #{numeric_sizes.first.name}" unless numeric_sizes.empty?
      ret << "-#{numeric_sizes.last.name}" if numeric_sizes.length > 1

      waist_sizes = self.send(type_method).where(category: 'inches')
      ret << " and waist #{waist_sizes.first.name}" unless waist_sizes.empty?
      ret << "-#{waist_sizes.last.name}" if waist_sizes.length > 1

      alpha_string = self.send(type_method).where(category: 'alpha')
                                           .map(&:name).join(' or ')
      alpha_string = "(#{alpha_string})" if ret != baseline
      ret << " #{alpha_string}"

      ret
    end

    def synopsis_budget
      ret = ""

      unless self.budget.top_range_string.nil?
        ret << "#{self.budget.top_range_string} on tops (shirts, blouses, sweaters)" 
      end
      unless self.budget.bottom_range_string.nil?
        ret << ', ' unless ret.blank?
        ret << "#{self.budget.bottom_range_string} on bottoms (slacks, skirts, jeans)" 
      end
      unless self.budget.dress_range_string.nil?
        ret << ', ' unless ret.blank?
        ret << "#{self.budget.dress_range_string} on dresses (everyday, work, transitional)" 
      end

      ret
    end

    def synopsis_considerations
      ret = ""

      unless self.special_considerations.empty?
        ret << "#{self.special_considerations.map{|sc| sc.name.downcase}.join(' and ')} fashion"
      end

      ret
    end

    def synopsis_looks
      ret = ""
      
      loved_looks = self.look_tolerances.where(tolerance: 10).map(&:look)
      hated_looks = self.look_tolerances.where(tolerance: 1).map(&:look)

      unless loved_looks.empty?
        ret << "loves the #{loved_looks.map{|l| l.name.gsub('_',' ').titleize}.join(' and ')}"
        ret << " #{loved_looks.count > 1 ? 'looks' : 'look'}"
      end
      unless hated_looks.empty?
        ret << ", but " unless ret.blank?
        ret << "hates the #{hated_looks.map{|l| l.name.gsub('_',' ').titleize}.join(' and ')}"
        ret << " #{hated_looks.count > 1 ? 'looks' : 'look'}"
      end

      ret
    end

    def synopsis_fit
      ret = ""

      ret << "her tops to be #{self.top_fit}" unless self.top_fit.blank?
      ret << " and " unless ret.blank? || self.bottom_fit.blank?
      ret << "her bottoms to be #{self.bottom_fit}" unless self.bottom_fit.blank?

      ret
    end

    def synopsis_coverage
      ret = ""
      
      parts_to_cover = self.part_exposure_tolerances.where(tolerance: 1).map(&:part)
      parts_to_flaunt = self.part_exposure_tolerances.where(tolerance: 10).map(&:part)

      unless parts_to_cover.empty?
        ret << "to cover her #{parts_to_cover.map{|p| p.name.downcase}.join(' and ')}"
      end
      unless parts_to_flaunt.empty?
        ret << ", and " unless ret.blank?
        ret << "to flaunt her #{parts_to_flaunt.map{|p| p.name.downcase}.join(' and ')}"
      end

      ret
    end

    def synopsis_prints
      ret = ""
      
      loved_prints = self.print_tolerances.where(tolerance: 10).map(&:print)
      hated_prints = self.print_tolerances.where(tolerance: 1).map(&:print)

      unless loved_prints.empty?
        ret << "loves #{loved_prints.map{|p| p.name.downcase}.join(' and ')}"
      end
      unless hated_prints.empty?
        ret << ", but " unless ret.blank?
        ret << "hates #{hated_prints.map{|p| p.name.downcase}.join(' and ')}"
      end

      ret
    end

    def synopsis_colors
      ret = ""

      colors = self.avoided_colors
      unless colors.empty?
        ret << "the #{colors.count > 1 ? 'colors' : 'color'} #{colors.map{|c| c.name.downcase}.join(', ')}"
      end

      ret
    end
end
