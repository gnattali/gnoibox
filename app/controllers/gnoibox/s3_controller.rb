# require 'openssl'
# require 'digest/sha1'
# require 'base64'

class Gnoibox::S3Controller < Gnoibox::ApplicationController
  skip_before_action :verify_authenticity_token

  def put_url
    render text: Gnoibox::S3.put_url(params[:name], params[:type])
  end

  def index
    render json: Gnoibox::S3.file_hash
  end

  def show

  end

end
