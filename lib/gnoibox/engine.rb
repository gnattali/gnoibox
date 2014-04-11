module Gnoibox
  class Engine < ::Rails::Engine
    isolate_namespace Gnoibox

    initializer "assets.path" do |app|
      app.config.assets.precompile += %w( glyphicons-halflings-regular.eot glyphicons-halflings-regular.woff glyphicons-halflings-regular.ttf redactor-font.eot )

      app.config.assets.paths << root.join("vendors", "detail-admin", "js")
      app.config.assets.paths << root.join("vendors", "detail-admin", "css")
      app.config.assets.paths << root.join("vendors", "detail-admin", "img")
      app.config.assets.paths << root.join("vendors", "detail-admin", "font")

      app.config.assets.paths << root.join("vendors", "redactor", "javascripts")
      app.config.assets.paths << root.join("vendors", "redactor", "stylesheets")
    end

    config.to_prepare do
      ::ApplicationController.helper(Gnoibox::ApplicationHelper)
    end
  end
end
