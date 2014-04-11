class Gnoibox::DashboardController < Gnoibox::ApplicationController

  def index
    @boxes = Gnoibox::BoxCollection.all.sort_by{|b| b.key==:root ? 0 : 1 }
    @blocks = Gnoibox::BlockCollection.all
  end

end
