module ManageImageInCDN
  extend ActiveSupport::Concern

  def self.upload(path_to_image, object_associated_with_image)
    @address = ParseAddress.get_address object_associated_with_image

    result = Cloudinary::Uploader.upload(path_to_image, :public_id => ImageName.get_image_name(object_associated_with_image),
      :tags => ["#{object_associated_with_image.class.to_s.downcase}", "state_#{@address.state}",
         "city_#{@address.city}", "postal_code_#{@address.postal_code}"] )
    image = object_associated_with_image.create_image(name: result["public_id"], url: result["url"],
                                              width: result["width"], height: result["height"],
                                              format: result["format"])
  end

  def self.delete_image image_obj
    if !image_obj.is_a? Image
      Cloudinary::Uploader.destroy(image_obj.name, :invalidate => true)
      image_obj.destroy
    end
  end
end