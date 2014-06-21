module Gnoibox
  class Axis::Point < Axis
    include Gnoibox::Axis::Type::Range

    set_key :point, '点数'

    set_option :over80point, '80点以上', range: (80..100)
    set_option :over50point, '50点以上', range: (50..100)
    set_option :over30point, '30点以上', range: (30..100)
  end
end
