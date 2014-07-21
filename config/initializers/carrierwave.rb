# configure in config/application.rb
#
# config.before_initialize do
#   Gnoibox::S3.configure do |config|
#     config.access_key_id = ENV['S3_ACCESS_KEY_ID']
#     config.secret_access_key = ENV['S3_SECRET_ACCESS_KEY']
#     config.region = ENV['S3_REGION']
#     config.bucket = ENV['S3_BUCKET']
#   end
# end


if Gnoibox::S3.access_key_id
  CarrierWave.configure do |config|
    config.fog_credentials = {
      :aws_access_key_id => Gnoibox::S3.access_key_id,
      :aws_secret_access_key => Gnoibox::S3.secret_access_key,
      :provider => 'AWS',
      :region => Gnoibox::S3.region
    }
    config.fog_directory = Gnoibox::S3.bucket
    config.fog_public = true
  end
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
