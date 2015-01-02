module Gnoibox
  class Box::Building < Box
    set_key :building, '物件'
    
    set_order_key :rent
  end
  
  class Item::Building < Item
    set_col :address, :address, '住所', axis: [Axis::Prefecture, Axis::City]
    (1..3).each do |n|
      set_col "station#{n}".to_sym, :station, "最寄駅#{n}", axis: [Axis::Railway, Axis::Station]
      set_col "walk#{n}".to_sym, :number, "駅徒歩#{n}", axis: Axis::Walk
    end
    set_col :rent, :number, '家賃', axis: Axis::PriceRange, unit: '円'
    set_col :age, :date, '築年月日', axis: Axis::Age
    set_col :item_type, :select, '物件種別', axis: Axis::ItemType
    set_col :floor_plan, :text, '間取り', axis: Axis::FloorPlan
    set_col :floor_space, :float, '面積', axis: Axis::FloorSpace, unit: '㎡'
    set_col :preferences, :check_box, 'こだわり条件', axis: Axis::Preference
    (1..10).each do |n|
      set_col "img#{n}".to_sym, :image, "画像#{n}"
      set_col "img#{n}_title".to_sym, :text, "キャプション#{n}"
    end
    set_col :body, :rich_text, '本文'
  end
end
