module Gnoibox
  module ApplicationHelper

    def gnb_title
      content_for(:title) || page.title
    end

    def gnb_description
      content_for(:description) || page.description
    end

    def gnb_keywords
      content_for(:keywords) || page.keywords
    end

    def gnb_og_image
      content_for(:og_image).presence || page.og_image
    end

    def gnb_og_type
      content_for(:og_type).presence || page.og_type
    end

    def gnb_body_class
      content_for(:body_class).presence || ''
    end

    def gnb
      Facade
    end

    class Facade
      class << self
        def axis(key)
          Gnoibox::AxisCollection::find(key)
        end
        def boxes
          @boxes ||= Gnoibox::BoxCollection::all.sort_by(&:position)
        end
        def box(key)
          Gnoibox::BoxCollection::find(key)
        end
        def blocks
          Gnoibox::BlockCollection::all
        end
        def block(key)
          Gnoibox::BlockCollection::load(key)
        end
      end
    end

  end
end
