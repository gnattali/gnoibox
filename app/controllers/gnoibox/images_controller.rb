class Gnoibox::ImagesController < Gnoibox::ApplicationController
  skip_before_action :verify_authenticity_token

  before_action :set_box

  def index
  end

  def show
  end

  def new
  end

  def create
    return if !(col_name = params[:col_name]) || !(source_url = params[:source_url])
    tmp_content = @box.new_item(status: 'draft').content
    tmp_content.send "#{col_name}_remote_source=", source_url
    col = tmp_content.send(col_name)
    if col.value.present?
      render json: {filename: col.value, url: col.image_url}
    else
      render json: {errors: "failed"}, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
    def set_box
      @box = Gnoibox::BoxCollection.find(params[:box_id])
    end

end
