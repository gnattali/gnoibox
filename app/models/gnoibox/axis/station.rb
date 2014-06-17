module Gnoibox
  class Axis::Station < Axis
    set_key :station, '駅'
    set_type :station

    def self.options
      Axis::Station.options
    end

    def self.find_all_tag(v)
      #TODO
    end

  end
end
