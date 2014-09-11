#can be overridden in app/models/gnoibox/box/root.rb
#or
#decorated using class_eval in app/decorators/models/gnoibox/box/root_decorator.rb
module Gnoibox
  class Box::Root < Box
    set_key :root, '固定ページ'
    set_collection_view 'index'
    set_member_view 'page'
    set_position 0

    def self.member_view(url_parser)
      url = url_parser.params[:first]
      Dir.glob("#{Rails.application.config.root}/app/views/gnoibox/site/#{url}.*").present? ? url : @member_view
    end
  end

  class Item::Root < Item
    # set_view_file_options ['', 'page']

    set_col :body, :rich_text, '本文'
  end
end
