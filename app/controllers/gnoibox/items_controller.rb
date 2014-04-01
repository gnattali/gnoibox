class Gnoibox::ItemsController < Gnoibox::ApplicationController
  before_action :set_box
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  def index
    @items = @box.items.page(params[:page]).per(1000)
  end

  def show
  end

  def new
    @item = @box.new_item
  end

  def create
    @item = @box.new_item(item_params)
    if @item.save
      redirect_to gnoibox_box_items_url(@box), notice: '保存されました'
    else
      render action: 'new'
    end
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to gnoibox_box_items_url(@box), notice: '保存されました'
    else
      render action: 'edit'
    end
  end

  def destroy
    @item.destroy
    redirect_to gnoibox_box_items_url(@box)
  end

  private
    def set_box
      @box = Gnoibox::BoxCollection.find(params[:box_id])
    end

    def set_item
      @item = @box.item_class.find(params[:id])
    end

    def item_params
      # @item.content.cols.each do |col|
      @box.item_cols.each do |col|
        params[:item][:content][col.name] = [] if col.type==:check_box && params[:item][:content][col.name]==nil
      end
      params.require(:item).permit!
    end
end
