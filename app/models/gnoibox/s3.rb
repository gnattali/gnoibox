# require 'forwardable'

module Gnoibox
  class S3
    class Configuration
      attr_accessor :access_key_id, :secret_access_key, :region, :bucket, :upload_dir
      
      def initialize
        @upload_dir = 'redactor'
      end
    end

    class << self
      extend Forwardable

      def configuration
        @configuration ||= Configuration.new
      end
      
      def configure
        yield(configuration)
      end

      def_delegators :configuration, :access_key_id, :secret_access_key, :region, :bucket, :upload_dir
      # def access_key_id() ACCESS_KEY_ID end
      # def secret_access_key() SECRET_ACCESS_KEY end
      # def region() REGION end
      # def bucket() BUCKET end
      # 
      # def upload_dir() 'redactor' end

      def put_url(name, type)
        expires = DateTime.now.to_i + (60 * 5)
        amzHeaders = "x-amz-acl:public-read"
        upload_path = "#{bucket}/#{upload_dir}/#{name}"
        stringToSign = "PUT\n\n#{type}\n#{expires}\n#{amzHeaders}\n/#{upload_path}";
        digest = OpenSSL::Digest::Digest.new('sha1')
        hmac = OpenSSL::HMAC.digest(digest, secret_access_key, stringToSign)
        signature = encode_signs URI.escape(Base64.encode64(hmac).strip)

        url = URI.escape "http://s3-#{region}.amazonaws.com/#{upload_path}?AWSAccessKeyId=#{access_key_id}&Expires=#{expires}&Signature=#{signature}"
      end

      def connection
        Fog::Storage.new({
          :provider                 => 'AWS',
          :aws_access_key_id        => access_key_id,
          :aws_secret_access_key    => secret_access_key,
          :region => region
        })
      end
      
      def uploaded_files
        connection.directories.get(bucket, prefix: upload_dir).files
      end

      
    private

      def encode_signs(s)
        signs = {'+' => "%2B", '=' => "%3D", '?' => '%3F', '@' => '%40',
          '$' => '%24', '&' => '%26', ',' => '%2C', '/' => '%2F', ':' => '%3A',
          ';' => '%3B', '?' => '%3F'}
        signs.keys.each do |key|
          s.gsub!(key, signs[key])
        end
        s
      end

    end
  end
end