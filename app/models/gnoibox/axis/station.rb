module Gnoibox
  class Axis::Station < Axis
    set_key :station, '駅'
    set_type :station

    def self.options
      Axis::Station.options
    end

    def self.detect_tag_for(v)
      #TODO
      #match railway and station
    end

  end
end
