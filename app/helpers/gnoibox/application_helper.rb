module Gnoibox
  module ApplicationHelper
    def gnb
      Facade
    end


    def content_for_title
      content_for(:title).presence || Gnoibox::Site.title
    end

    def content_for_description
      content_for(:description).presence || Gnoibox::Site.description
    end

    def content_for_keywords
      content_for(:keywords).presence || Gnoibox::Site.keywords
    end

    def content_for_og_image
      content_for(:og_image).presence || "http://#{request.host_with_port}/#{Gnoibox::Site.default_image}"
    end

    def content_for_og_type
      content_for(:og_type).presence || 'website'
    end

    def body_class
      content_for(:body_class).presence || ''
    end

    class Facade
      class << self
        def box(key)
          Gnoibox::BoxCollection::find(key)
        end
        def block(key)
          Gnoibox::BlockCollection::load(key)
        end
      end
    end

  end
end
