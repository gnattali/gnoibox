module Gnoibox
  module ApplicationHelper

    def gnb_title
      # (content_for(:title) || page.title) + (current_page?("/") ? "" : " - #{gnb_base_info.site_name}")
      content_for(:title) || page.title
    end
    alias_method :gnb_og_title, :gnb_title

    def gnb_description
      content_for(:description) || page.description
    end
    alias_method :gnb_og_description, :gnb_description

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

    def gnb_base_info
      #fallback to yml info?
      @gnb_base_info ||= gnb.block(:base_info)
    end

    def gnb_render_form
      render "gnoibox/site/form"
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
          Gnoibox::BoxCollection::all
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
        def forms
          Gnoibox::FormCollection::all
        end
      end
    end

  end
end
