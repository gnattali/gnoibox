require 'csv'

module Gnoibox
  class Axis::City < Axis
    set_key :city, '市区町村'
    set_type :city
    
    CSV.foreach(File.join(Gnoibox::Engine.root, "db", "seeds", "cities.csv")) do |r|
      set_option "city_#{r[3]}", r[2], {prefecture_id: r[0], city_id: r[1]}
    end

    def self.detect_tag_for(v)
      #TODO
    end
    
  end
end
