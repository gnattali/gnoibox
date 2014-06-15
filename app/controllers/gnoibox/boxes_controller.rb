class Gnoibox::BoxesController < Gnoibox::ApplicationController
  before_action :set_box, only: [:show]

  def index
    @boxes = Gnoibox::BoxCollection.all.sort_by{|b| [:root, :facet].include?(b.key) ? 0 : 1 }
  end

  def show
    redirect_to gnoibox_box_items_path(@box)
  end

  private
    def set_box
      @box = Gnoibox::BoxCollection.find(params[:id])
    end
end
