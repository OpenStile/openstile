# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base

  include Cloudinary::CarrierWave

  process :convert => 'jpg'

  version :standard do
    process :resize_to_fill => [500, 500]
  end

  # TODO: Figure out how to set file name
  # def filename
  #   ImageName.get_image_name() if original_filename
  # end

end
