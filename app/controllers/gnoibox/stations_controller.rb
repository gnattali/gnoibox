class Gnoibox::StationsController < Gnoibox::ApplicationController
  # skip_before_action :verify_authenticity_token

  def index
    render json: Gnoibox::Station.select2_options_for(params[:q])
  end

end
