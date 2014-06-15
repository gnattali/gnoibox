module Gnoibox
  class Box::Facet < Box
    set_key :facet, '切り口ページ'
  end
  
  class Item::Facet < Item
    set_col :body, :rich_text, '本文'
  end
end
