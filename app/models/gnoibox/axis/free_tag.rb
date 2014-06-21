module Gnoibox
  class Axis::FreeTag < Axis
    include Gnoibox::Axis::Type::Free

    set_key :free_tag, '任意タグ'

    set_delimiter ','
  end
end
