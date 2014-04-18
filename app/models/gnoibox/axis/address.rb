module Gnoibox
  class Axis::Address < Axis
    set_key :address, '住所'
    set_type :prefecture

    def self.options
      Axis::Prefecture.options
    end
  end
end
