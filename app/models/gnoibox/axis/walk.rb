module Gnoibox
  class Axis::Walk < Axis
    set_key :walk, '駅徒歩'
    set_type :range

    set_option :in_3minutes, '3分以内', range: (0..3)
    set_option :in_5minutes, '5分以内', range: (0..5)
    set_option :in_10minutes, '10分以内', range: (0..10)
  end
end
