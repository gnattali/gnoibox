module Gnoibox
  class Axis::Railway < Axis
    set_key :railway, '路線'
    set_type :railway

    def self.options
      Axis::Railway.options
    end

    def self.detect_tag_for(v)
      #TODO
    end

  end
end
