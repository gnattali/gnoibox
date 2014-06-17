module Gnoibox
  class Axis::Railway < Axis
    set_key :railway, '路線'
    set_type :railway

    def self.options
      Axis::Railway.options
    end

    def self.find_all_tag(v)
      #TODO
    end

  end
end
