module ImageName
  extend ActiveSupport::Concern

  IMAGE_FILE_EXTENSION = 'jpg'

  def image_path_root
    return self.retailer.image_path_root if respond_to? :retailer

    address = ParseAddress.get_address self
    state = address.state.gsub(' ','_')
    city = address.city.gsub(' ','_')

    "#{remove_special_characters(state)}/#{remove_special_characters(city)}/#{remove_special_characters(self.name)}"
  end

  def cover_photo
    "#{image_path_root}/cover_photo.#{IMAGE_FILE_EXTENSION}"
  end

  def sample_photos
    base = "#{image_path_root}/sample_photo"
    (1..4).to_a.map{|n| "#{base}/#{n}.#{IMAGE_FILE_EXTENSION}" }
  end

  def logo
    "#{image_path_root}/logo.#{IMAGE_FILE_EXTENSION}"
  end

  private

    def remove_special_characters dirty_string
      transliterated_string = ActiveSupport::Inflector.transliterate dirty_string
      sanatized_string = transliterated_string.gsub(/([_@#!%()\-\'=;><,{}\~\[\]\s\.\:\/\?\"\*\^\$\+\-]+)/, '_').downcase
    end
end
