module ImageName
  extend ActiveSupport::Concern

  def image_name
    return 'sample_item' if Rails.env.development?

    address = ParseAddress.get_address self
    state = address.state.gsub(' ','_')
    city = address.city.gsub(' ','_')

    if self.respond_to?("location")
      retailer_name = self.name.gsub(' ','_')
      concatenated_fields = [state, city, retailer_name].join('_')
    elsif self.respond_to?("retailer")
      retailer_name = Retailer.find_by_id(self.retailer_id).name.gsub(' ','_')
      item_name = self.name.gsub(' ','_')
      concatenated_fields = [state, city, retailer_name, item_name].join('_')
    end

    image_name = remove_spcial_characters(concatenated_fields)
  end

  private

    def remove_spcial_characters dirty_string
      transliterated_string = ActiveSupport::Inflector.transliterate dirty_string
      sanatized_string = transliterated_string.gsub(/([_@#!%()\-\'=;><,{}\~\[\]\s\.\:\/\?\"\*\^\$\+\-]+)/, '_').downcase
    end
end
