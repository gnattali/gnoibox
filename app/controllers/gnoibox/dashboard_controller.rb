class Gnoibox::DashboardController < Gnoibox::ApplicationController

  def index
    @boxes = Gnoibox::BoxCollection.all
    @boxes = @boxes.reject{|box| [:root, :facet].include? box.key } unless gnb_admin?

    @blocks = Gnoibox::BlockCollection.all

    @forms = Gnoibox::FormCollection.all
  end

end
