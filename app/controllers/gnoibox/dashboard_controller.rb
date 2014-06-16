class Gnoibox::DashboardController < Gnoibox::ApplicationController

  def index
    @boxes = Gnoibox::BoxCollection.all
    @blocks = Gnoibox::BlockCollection.all
  end

end
