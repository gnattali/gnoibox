module Gnoibox
  class Engine < ::Rails::Engine
    isolate_namespace Gnoibox

    initializer "assets.path" do |app|
      app.config.assets.precompile += %w( *.eot *.woff *.ttf *.svg *.png *.gif gnoibox/custom.css )

      app.config.assets.paths << root.join("vendors", "detail-admin", "js")
      app.config.assets.paths << root.join("vendors", "detail-admin", "css")
      app.config.assets.paths << root.join("vendors", "detail-admin", "img")
      app.config.assets.paths << root.join("vendors", "detail-admin", "font")

      app.config.assets.paths << root.join("vendors", "redactor", "javascripts")
      app.config.assets.paths << root.join("vendors", "redactor", "stylesheets")
    end

    config.to_prepare do
      ::ApplicationController.helper(Gnoibox::ApplicationHelper)

      Dir.glob(Rails.root + "app/decorators/**/*_decorator.rb").each do |c|
        require_dependency(c)
      end

    end
  end
end
