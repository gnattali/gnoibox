module Gnoibox
  class Box::Article < Box
    set_key :articles, '記事'
    set_collection_view 'article_list'
    set_member_view 'article'
  end

  class Item::Article < Item
    set_col :category, :radio, 'カテゴリー', axis: Axis::Category
    set_col :body, :rich_text, '本文'
  end
end
