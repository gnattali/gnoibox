# define in app/models/gnoibox/s3.rb
# module Gnoibox
#   module S3
#     ACCESS_KEY_ID = ''
#     SECRET_ACCESS_KEY = ''
#     REGION = ''
#     BUCKET = ''
#   end
# end

CarrierWave.configure do |config|
  config.fog_credentials = {
    :aws_access_key_id => Gnoibox::S3::ACCESS_KEY_ID,
    :aws_secret_access_key => Gnoibox::S3::SECRET_ACCESS_KEY,
    :provider => 'AWS',
    :region => Gnoibox::S3::REGION
  }
  config.fog_directory = Gnoibox::S3::BUCKET
  config.fog_public = true
end


module CarrierWave
  module MiniMagick

    # Rotates the image based on the EXIF Orientation
    def fix_exif_rotation
      manipulate! do |img|
        img.auto_orient!
        img = yield(img) if block_given?
        img
      end
    end

    # Strips out all embedded information from the image
    def strip
      manipulate! do |img|
        img.strip!
        img = yield(img) if block_given?
        img
      end
    end

  end
end
