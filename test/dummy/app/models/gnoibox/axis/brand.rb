module Gnoibox
  class Axis::Brand < Axis
    include Gnoibox::Axis::Type::Free

    set_key :brand, '銘柄'

    set_delimiter ','
  end
end
