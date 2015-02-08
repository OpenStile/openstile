module ImageName
  extend ActiveSupport::Concern

  def self.get_image_name obj

    if obj.respond_to?("location")
      address = StreetAddress::US.parse(obj.location.address)
      state = address.state.gsub(' ','_')
      city = address.city.gsub(' ','_')
      retailer_name = obj.name.gsub(' ','_')
      @concatenated_fields = [state, city, retailer_name].join('_')
    elsif obj.respond_to?("retailer")
      address = StreetAddress::US.parse(obj.retailer.location.address)
      state = address.state.gsub(' ','_')
      city = address.city.gsub(' ','_')
      retailer_name = Retailer.find_by_id(obj.retailer_id).name.gsub(' ','_')
      item_name = obj.name.gsub(' ','_')
      @concatenated_fields = [state, city, retailer_name, item_name].join('_')
    end

    image_name = remove_spcial_characters(@concatenated_fields)
  end

  def self.remove_spcial_characters dirty_string
    transliterated_string = ActiveSupport::Inflector.transliterate dirty_string
    sanatized_string = transliterated_string.gsub(/([_@#!%()\-\'=;><,{}\~\[\]\s\.\:\/\?\"\*\^\$\+\-]+)/, '_').downcase
  end
end