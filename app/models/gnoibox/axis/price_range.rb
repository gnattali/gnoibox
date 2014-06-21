module Gnoibox
  class Axis::PriceRange < Axis
    include Gnoibox::Axis::Type::Range

    set_key :price_range, '価格帯'

    set_option :in50k, '5万円以下', range: (0..50000)
    set_option :from50k_to70k, '5〜7万円', range: (50001..70000)
    set_option :from70k_to100k, '7〜10万円', range: (70001..100000)
    set_option :from100k_to200k, '10〜20万円', range: (100001..200000)
    set_option :from200k_to300k, '20〜30万円', range: (200001..300000)
    set_option :from300k, '30万円以上', range: (300001..9999999999)
  end
end
