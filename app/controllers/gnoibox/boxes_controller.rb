class Gnoibox::BoxesController < Gnoibox::ApplicationController
  before_action :set_box, only: [:show, :col_labels]

  def index
    @boxes = Gnoibox::BoxCollection.all
    @boxes = @boxes.reject{|box| [:root, :facet].include? box.key } unless gnb_admin?
  end

  def show
    redirect_to gnoibox_box_items_path(@box)
  end

  def col_labels
    cols = @box.base_col_names + @box.content_col_names
    # render text: cols.join(',') + "\n" + (@box.base_col_names.map{|col| @box.label_for(col) } + @box.item_cols.map(&:label)).join(',')
  end
  
  private
    def set_box
      @box = Gnoibox::BoxCollection.find(params[:id])
    end
end
