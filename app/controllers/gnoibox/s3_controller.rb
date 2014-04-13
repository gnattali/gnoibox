# require 'openssl'
# require 'digest/sha1'
# require 'base64'

class Gnoibox::S3Controller < Gnoibox::ApplicationController
  skip_before_action :verify_authenticity_token

  def url
    key = Gnoibox::S3::ACCESS_KEY_ID
    secret = Gnoibox::S3::SECRET_ACCESS_KEY
    bucket = Gnoibox::S3::BUCKET

    objectName = params[:name]
    mimeType = params[:type]
    expires = DateTime.now.to_i + (60 * 5)
    amzHeaders = "x-amz-acl:public-read"
    stringToSign = "PUT\n\n#{mimeType}\n#{expires}\n#{amzHeaders}\n#{bucket}#{objectName}";
    digest = OpenSSL::Digest::Digest.new('sha1')
    hmac = OpenSSL::HMAC.digest(digest, secret, stringToSign)
    signature = encode_signs URI.escape(Base64.encode64(hmac).strip)

    url = URI.escape "http://s3.amazonaws.com/#{bucket}/#{objectName}?AWSAccessKeyId=#{key}&Expires=#{expires}&Signature=#{signature}"

    render text: url
  end

  def index

  end

  def show

  end

private

  # module Aws
  #   extend self
  #   def signed_url(path, expire_date)
  #     digest = OpenSSL::Digest::Digest.new('sha1')
  #     can_string = "GET\n\n\n#{expire_date}\n/#{S3_BUCKET}/#{path}"
  #     hmac = OpenSSL::HMAC.digest(digest, S3_SECRET_ACCESS_KEY, can_string)
  #     signature = URI.escape(Base64.encode64(hmac).strip).encode_signs
  #     "https://s3.amazonaws.com/#{S3_BUCKET}/#{path}?AWSAccessKeyId=#{S3_ACCESS_KEY_ID}&Expires=#{expire_date}&Signature=#{signature}"
  #   end
  # end

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
