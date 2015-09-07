
class StyleProfile < ActiveRecord::Base
  belongs_to :shopper
  belongs_to :body_shape
  belongs_to :top_fit
  belongs_to :bottom_fit
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
  has_and_belongs_to_many :body_builds

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

  def synopsis_considerations
    ret = ""

    unless self.special_considerations.empty?
      ret << "#{readable_list(self.special_considerations.map{|sc| sc.name.downcase})} fashion"
    end

    ret
  end

  def synopsis_loved_looks
    ret = ""
    
    loved_looks = self.look_tolerances.where(tolerance: 10).map(&:look)
    unless loved_looks.empty?
      ret << readable_list(loved_looks.map{|l| l.name.gsub('_','-').downcase})
    end

    ret
  end

  def synopsis_hated_looks
    ret = ""
    
    hated_looks = self.look_tolerances.where(tolerance: 1).map(&:look)
    unless hated_looks.empty?
      ret << readable_list(hated_looks.map{|l| l.name.gsub('_','-').downcase})
    end

    ret
  end

  def synopsis_array_tops
    ret = []

    ret << "size #{assemble_sizes :top_sizes}"
    ret << "#{self.top_fit.name}" unless self.top_fit.nil?
    ret << "#{self.budget.top_range_string}"

    ret.select{|detail| !detail.blank?}
  end

  def synopsis_array_bottoms
    ret = []

    ret << "size #{assemble_sizes :bottom_sizes}"
    ret << "#{self.bottom_fit.name}" unless self.bottom_fit.nil?
    ret << "#{self.budget.bottom_range_string}"

    ret.select{|detail| !detail.blank?}
  end

  def synopsis_array_dresses
    ret = []

    ret << "size #{assemble_sizes :dress_sizes}"
    ret << "#{self.budget.dress_range_string}"

    ret.select{|detail| !detail.blank?}
  end

  def synopsis_additional_details
    parts_to_cover = self.part_exposure_tolerances.where(tolerance: 1).map(&:part)
    parts_to_flaunt = self.part_exposure_tolerances.where(tolerance: 10).map(&:part)
    loved_prints = self.print_tolerances.where(tolerance: 10).map(&:print)
    hated_prints = self.print_tolerances.where(tolerance: 1).map(&:print)

    ret = []

    ret << "Keeps her #{readable_list(parts_to_cover
                       .map{|p| p.name.downcase})} covered" unless parts_to_cover.empty?
    ret << "Flaunts her #{readable_list(parts_to_flaunt
                       .map{|p| p.name.downcase})}" unless parts_to_flaunt.empty?
    ret << "Loves #{readable_list(loved_prints
                       .map{|p| p.name.downcase})}" unless loved_prints.empty?
    ret << "Hates #{readable_list(hated_prints
                       .map{|p| p.name.downcase})}" unless hated_prints.empty?
    ret << "Avoids #{readable_list(avoided_colors
                       .map{|c| c.name.downcase})}" unless avoided_colors.empty?

    ret.select{|detail| !detail.blank?}
  end

  private
    def readable_list list_of_strings
      if list_of_strings.size <= 2
        return list_of_strings.join(' and ')
      else
        list_of_strings[-1] = "and #{list_of_strings[-1]}"
        return list_of_strings.join(', ')
      end
    end

    def assemble_sizes type_method
      ret = ""
      return ret if self.send(type_method).empty?

      numeric_sizes = self.send(type_method).where(category: 'numeric')
      ret << " #{numeric_sizes.first.name}" unless numeric_sizes.empty?
      ret << "-#{numeric_sizes.last.name}" if numeric_sizes.length > 1

      waist_sizes = self.send(type_method).where(category: 'inches')
      ret << " and waist #{waist_sizes.first.name}" unless waist_sizes.empty?
      ret << "-#{waist_sizes.last.name}" if waist_sizes.length > 1

      alpha_string = self.send(type_method).where(category: 'alpha')
                                           .map(&:name).join(' or ')
      alpha_string = "(#{alpha_string})" if ret != ""
      ret << " #{alpha_string}"

      ret
    end
end
