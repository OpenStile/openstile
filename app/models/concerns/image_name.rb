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

  def image_name
    return 'sample_item' if Rails.env.development?

    leaf_name = self.respond_to?(:retailer) ? remove_special_characters(self.name) : 'storefront'
    "#{image_path_root}/#{leaf_name}.#{IMAGE_FILE_EXTENSION}"
  end

  def image_alt_text
    image_name.gsub(".#{IMAGE_FILE_EXTENSION}", '').gsub('/','_')
  end

  def logo_image_name
    return 'sample_logo' if Rails.env.development?
    "#{image_path_root}/logo.#{IMAGE_FILE_EXTENSION}"
  end

  private

    def remove_special_characters dirty_string
      transliterated_string = ActiveSupport::Inflector.transliterate dirty_string
      sanatized_string = transliterated_string.gsub(/([_@#!%()\-\'=;><,{}\~\[\]\s\.\:\/\?\"\*\^\$\+\-]+)/, '_').downcase
    end
end
