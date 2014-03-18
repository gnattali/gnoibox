module Gnoibox
  class Engine < ::Rails::Engine
    isolate_namespace Gnoibox
    
    config.to_prepare do
      ::ApplicationController.helper(Gnoibox::ApplicationHelper)
    end
  end
end
