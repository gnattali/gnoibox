#can be overridden
module Gnoibox
  class Box::Root < Box
    set_key :root, '固定ページ'
    set_collection_view 'top'
    set_member_view 'page'
    set_position 0

    def self.member_view(url_parser)
      url_parser.params[:first]
    end
  end

  class Item::Root < Item
    # set_view_file_options ['', 'page']

    set_col :body, :rich_text, '本文'
  end
end
