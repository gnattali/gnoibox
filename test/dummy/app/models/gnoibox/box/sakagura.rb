module Gnoibox
  class Box::Sakagura < Box
    set_key :sakagura, '酒蔵'
  end
  
  class Item::Sakagura < Item
    set_col :address, :address, '住所', axis: [Axis::Prefecture, Axis::City]
    set_col :body, :rich_text, '本文'
    (1..10).each do |n|
      set_col "img#{n}".to_sym, :image, "画像#{n}"
      set_col "img#{n}_title".to_sym, :text, "キャプション#{n}"
    end
  end
end
