class Gnoibox::BlocksController < Gnoibox::ApplicationController
  before_action :set_block, only: [:show, :edit, :update]

  def index
    @blocks = Gnoibox::BlockCollection.all
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
    def set_block
      @block = Gnoibox::BlockCollection.load_substance(params[:id])
    end

    def block_params
      params[:block].permit!
    end
end
