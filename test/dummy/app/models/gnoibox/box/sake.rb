module Gnoibox
  class Box::Sake < Box
    set_key :sake, '日本酒'
    set_comment "銘柄毎"
  end
  
  class Item::Sake < Item
    # set_col :sakagura, :parent, belongs_to: Box::Sakagura
    set_col :prefecture, :select, '都道府県', axis: Axis::Prefecture
    set_col :brand, :text, '銘柄', axis: Axis::Brand
    set_col :category, :select, '種別', axis: Axis::Category
    set_col :preferences, :text, '特徴', axis: Axis::FreeTag
    set_col :body, :rich_text, '本文'
    (1..10).each do |n|
      set_col "img#{n}".to_sym, :image, "画像#{n}"
      set_col "img#{n}_title".to_sym, :text, "キャプション#{n}"
    end
  end
end
