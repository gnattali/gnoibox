module Gnoibox
  class Box::Root < Box
    set_key :root, '固定ページ'
    set_collection_view 'index'
    set_member_view 'page'
  end

  class Item::Root < Item
    # set_view_file_options ['about', 'access']

    set_col :body, :rich_text, '本文'
  end
end
