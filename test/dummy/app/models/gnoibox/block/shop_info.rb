module Gnoibox
  class Block::ShopInfo < Block
    set_key :shop_info, 'ショップ情報'
    set_comment "フッターやアクセスに表示する基本情報"

    set_col :address, :text, '住所'
    set_col :nearest_station, :text, '最寄り駅'
  end
end
