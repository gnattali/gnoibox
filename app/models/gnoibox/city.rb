require 'csv'

module Gnoibox
  class City
    def self.arrays
      #prefecture_id,city_id,title,city_key
      @arrays ||= CSV.read(File.join(Gnoibox::Engine.root, "db", "seeds", "cities.csv"))
    end
  end
end
