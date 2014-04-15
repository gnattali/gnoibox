class Gnoibox::AuthorsController < Gnoibox::ApplicationController
  before_action :set_author, only: [:show, :edit, :update]

  def index
    @authors = Gnoibox::Author.all
  end

  def show
  end

  def edit
  end

  def update
    respond_to do |format|
      if @block.update(block_params)
        format.html { redirect_to gnoibox_blocks_path, notice: '保存されました' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @block.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def set_author
      @author = Gnoibox::Author.find(params[:id])
    end

    def author_params
      params[:author].permit!
    end
end
